/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "configure.h"
#include "md5.h"
#include "xuartlite_l.h"
#include "xparameters.h"
#define UART_BASEADDR XPAR_UARTLITE_0_BASEADDR
#define STAMP_SIZE 153600
#define STAMP_1_BASE 0
#define STAMP_2_BASE STAMP_SIZE
#define STAMP_3_BASE STAMP_SIZE*2
#define STAMP_4_BASE STAMP_SIZE*3

// Pointer to the external memory
volatile unsigned int * memptr = (unsigned int*) XPAR_MIG_7SERIES_0_BASEADDR;

u8 finish = 0;
void read_data() {
	int i = 0;
    xil_printf("\n\rPlease send your file\n\r");
    while (!XUartLite_IsReceiveEmpty(UART_BASEADDR)) {
    	 XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
    }
    while (XUartLite_IsReceiveEmpty(UART_BASEADDR));
    //Write words to memory
    xil_printf("BEGIN READ FROM UART\n\r");
    for (i = STAMP_1_BASE; i<STAMP_2_BASE; i += 1) {
    	char q = XUartLite_RecvByte(UART_BASEADDR);
    	memptr[i] = q;
    }
    xil_printf("\n\rTIME_OUT: %d Bytes transfered into DDR3\n\r", i);

    // Flush
    while (!XUartLite_IsReceiveEmpty(UART_BASEADDR))
    	XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);

    xil_printf("\n\rPlease send your second file\n\r");
	while (!XUartLite_IsReceiveEmpty(UART_BASEADDR)) {
		XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
	}
	while (XUartLite_IsReceiveEmpty(UART_BASEADDR));
	//Write words to memory
	xil_printf("BEGIN READ FROM UART\n\r");
	for (i = STAMP_2_BASE; i<STAMP_3_BASE; i += 1) {
		char q = XUartLite_RecvByte(UART_BASEADDR);
		memptr[i] = q;
	}
	xil_printf("\n\rTIME_OUT: %d Bytes transfered into DDR3\n\r", i);

	// Flush
	while (!XUartLite_IsReceiveEmpty(UART_BASEADDR))
		XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);

	xil_printf("\n\rPlease send your third file\n\r");
	while (!XUartLite_IsReceiveEmpty(UART_BASEADDR)) {
		XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
	}
	while (XUartLite_IsReceiveEmpty(UART_BASEADDR));
	//Write words to memory
	xil_printf("BEGIN READ FROM UART\n\r");
	for (i = STAMP_3_BASE; i<STAMP_4_BASE; i += 1) {
		char q = XUartLite_RecvByte(UART_BASEADDR);
		memptr[i] = q;
	}
	xil_printf("\n\rTIME_OUT: %d Bytes transfered into DDR3\n\r", i);

	// Flush
	while (!XUartLite_IsReceiveEmpty(UART_BASEADDR))
		XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
}

void print_menu()
{
	xil_printf("**************************************************\n\r");
	xil_printf("*                Draw Stamp Demo                 *\n\r");
	xil_printf("**************************************************\n\r");
	xil_printf("\n\r");
	xil_printf("0 - read image\n\r");
	xil_printf("1 - start stamping!\n\r");
	xil_printf("2 - test memory\n\r");
	xil_printf("q - Quit\n\r");
	//memptr[0] = 65;
	//memptr[1] = 66;
	xil_printf("\n\r");
	xil_printf("\n\r");
	xil_printf("Enter a selection:");
}

u8 hash(u8 key)
{
 key += ~(key << 15);
 key ^= (key >> 10);
 key += (key << 3);
 key ^= (key >> 6);
 key += ~(key << 11);
 key ^= (key >> 16);
 return key;
}

void test_mem() {
	int i, j;
	int k = 0;
	 // Write TEST_SIZE words to memory
	 print("\n\r\n\rBEGIN WRITE\n\r");
	 read_data();
	 // Read TEST_SIZE words to memory and compare with golden values
	 unsigned char c[16];
	 MD5_CTX mdContext;
	 unsigned char data[1024];
	 MD5_Init (&mdContext);
	 for (i = 0; i<150; i += 1) {
		 for (j=0; j<1024;j+=1) {
			 data[j]=(unsigned char)(memptr[k] >> (4*4)) & 0xff;
			 k+=1;
		 }
		 MD5_Update (&mdContext, data, 1024);
	 }

	 MD5_Final (c,&mdContext);
	 for(i = 0; i < 16; i++) xil_printf("%02x", c[i]);
	 xil_printf("\n\r");
	 return;
}



void run_stamp()
{
	char userInput = 0;

	// Flush UART FIFO
	while (!XUartLite_IsReceiveEmpty(UART_BASEADDR))
	{
		XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
	}
	while (userInput != 'q')
	{
		// Flush UART FIFO
		while (!XUartLite_IsReceiveEmpty(UART_BASEADDR))
		{
			XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
		}
		print_menu();

		// Wait for data on UART
		while (XUartLite_IsReceiveEmpty(UART_BASEADDR))
		{}

		// Store the first character in the UART receive FIFO and echo it
		if (!XUartLite_IsReceiveEmpty(UART_BASEADDR))
		{
			userInput = XUartLite_ReadReg(UART_BASEADDR, XUL_RX_FIFO_OFFSET);
			xil_printf("%c", userInput);
		}

		switch (userInput)
		{
		case '0':
			read_data();
			break;
		case '1':
			//start_stamp();
			break;
		case '2':
			test_mem();
			break;
		case 'q':
			break;
		default :
			xil_printf("\n\rInvalid Selection\n\r");
		}
	}
	return;
}

int main()
{
    int i, k, j;
	init_platform();
	//run_stamp();
    print("Hello World\n\r");

	//configure the Tracking IP to track red object
	//TrackingInit(0xff0000, 0x0a0a0a);

	//initial VDMA
	VDMAInit(DDR_FB);

	//start display
	DrawBG(DDR_FB, 0xffffff);
	drawsquare(370, 130, 0xf10000);
	TFTDisplay(DDR_FB);

/*
	while(1){
		VDMAStart();
		for(i=0;i<500000;i++);
		VDMAStop();

		//TrackingRun();
		//print the position of the red object for each frame
		//if(* TK_ST == 1);{
			//if((*TK_XP !=-1)&(*TK_YP!=-1)){
				//drawsquare(*TK_XP, *TK_YP, 0xf10000);
				//printf("x = %d, y = %d\n" ,* TK_XP,* TK_YP);
				//int y_ptr = *(TK_YP)*320 + *TK_XP;
				//for(k=0;k<240;k+=1) {
				//	for (i=y_ptr;i<y_ptr+320;i+=1) {
				//		DDR_FB[i]=memptr[j];
				//		j += 1;
				//	}
				//	y_ptr =y_ptr - 319 + 640;
				//}
			//}
		//}
	}
	*/

    cleanup_platform();
    return 0;
}
