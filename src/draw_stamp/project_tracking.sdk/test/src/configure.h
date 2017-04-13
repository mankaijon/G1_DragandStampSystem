


//Frame buffer in DDR
volatile unsigned int * DDR_FB = (unsigned int *)0x80400000;




//tracking RED object
volatile unsigned int * TK_R_BS = (unsigned int *)0x44A20000;//control
volatile unsigned int * TK_R_RF = (unsigned int *)0x44A20004;//reference
volatile unsigned int * TK_R_TH = (unsigned int *)0x44A20008;//thershold
volatile unsigned int * TK_R_ST = (unsigned int *)0x44A2000c;//status
volatile unsigned int * TK_R_XP = (unsigned int *)0x44A20010;//X pos
volatile unsigned int * TK_R_YP = (unsigned int *)0x44A20014;//Y_pos

void TrackingInit_R(int ref, int th)
{
	*(TK_R_RF) = ref;
	*(TK_R_TH) = th;
}

void TrackingRun_R()
{
	*(TK_R_BS) = 0x1;
}

//tracking GREEN object
volatile unsigned int * TK_B_BS = (unsigned int *)0x44A30000;//control
volatile unsigned int * TK_B_RF = (unsigned int *)0x44A30004;//reference
volatile unsigned int * TK_B_TH = (unsigned int *)0x44A30008;//thershold
volatile unsigned int * TK_B_ST = (unsigned int *)0x44A3000c;//status
volatile unsigned int * TK_B_XP = (unsigned int *)0x44A30010;//X pos
volatile unsigned int * TK_B_YP = (unsigned int *)0x44A30014;//Y_pos

void TrackingInit_B(int ref, int th)
{
	*(TK_B_RF) = ref;
	*(TK_B_TH) = th;
}

void TrackingRun_B()
{
	*(TK_B_BS) = 0x1;
}


//VDMA
volatile unsigned int * VDMA_BS = (unsigned int *)0x44A10000;//baseaddress
volatile unsigned int * VDMA_CR = (unsigned int *)0x44A10030;//control for the s2mm
volatile unsigned int * VDMA_AD = (unsigned int *)0x44A100AC;//Address tie store the pixel
volatile unsigned int * VDMA_ST = (unsigned int *)0x44A100A8;//stride(larger than 4*640)
volatile unsigned int * VDMA_HS = (unsigned int *)0x44A100A4;//Hori size in byte
volatile unsigned int * VDMA_VS = (unsigned int *)0x44A100A0;//vertical size in line

void VDMAInit(unsigned int * buffer, int display_columns)
{
	*(VDMA_AD) = (int )buffer;
	*(VDMA_ST) = 4096;
	*(VDMA_HS) = 4*display_columns;
}
void VDMAStart(int display_rows)
{
	*(VDMA_CR) = 0x1;
	*(VDMA_VS) = display_rows;
}
void VDMAStop()
{
	*(VDMA_CR) = 0x0;
}
//VDMA for drawing
//read channel
volatile unsigned int * VDMA1_R_CR = (unsigned int *)0x44A40000;//baseaddress
volatile unsigned int * VDMA1_R_AD = (unsigned int *)0x44A4005C;//Address tie store the pixel
volatile unsigned int * VDMA1_R_ST = (unsigned int *)0x44A40058;//stride(larger than 4*640)
volatile unsigned int * VDMA1_R_HS = (unsigned int *)0x44A40054;//Hori size in byte
volatile unsigned int * VDMA1_R_VS = (unsigned int *)0x44A40050;//vertical size in line


//write channel
volatile unsigned int * VDMA1_W_CR = (unsigned int *)0x44A40030;//control for the s2mm
volatile unsigned int * VDMA1_W_AD = (unsigned int *)0x44A400AC;//Address tie store the pixel
volatile unsigned int * VDMA1_W_ST = (unsigned int *)0x44A400A8;//stride(larger than 4*640)
volatile unsigned int * VDMA1_W_HS = (unsigned int *)0x44A400A4;//Hori size in byte
volatile unsigned int * VDMA1_W_VS = (unsigned int *)0x44A400A0;//vertical size in line
//read function
void VDMA1_read_init(unsigned int*buffer, int columns){
	*(VDMA1_R_AD) = (int )buffer;
	*(VDMA1_R_ST) = 320*4;
	*(VDMA1_R_HS) = 4*columns;
}
void VDMA1_read_Start(int rows)
{
	*(VDMA1_R_CR) = 0x1;
	*(VDMA1_R_VS) = 240;
}
void VDMA1_read_Stop()
{
	*(VDMA1_R_CR) = 0x0;
}
//write function
void VDMA1_write_Init(unsigned int * buffer, int display_columns)
{
	*(VDMA1_W_AD) = (int )buffer;
	*(VDMA1_W_ST) = 4096;
	*(VDMA1_W_HS) = 4*display_columns;
}
void VDMA1_write_Start(int display_rows)
{
	*(VDMA1_W_CR) = 0x1;
	*(VDMA1_W_VS) = display_rows;
}
void VDMA1_write_Stop()
{
	*(VDMA1_W_CR) = 0x0;
}

//TFT
volatile unsigned int * TFT = (unsigned int *)0x44A00000;

void TFTDisplay(volatile unsigned int *buffer)
{
	*(TFT)=(int)buffer;
}
void DrawBG(volatile unsigned int * buffer, int colour)
{
	int i;
	for(i=0;i<(1<<21); i++)
		*(buffer+i)=colour;
}

//draw a blue square on the tracking position
void drawsquare(int x, int y, int colour){

	int i, j;
	int *draw_pos;
	for(i = -120;i<120;i++){
		for(j = -50; j<50;j++){
			draw_pos = (int)DDR_FB + ((y+i)<<12) + ((x+j)<<2);
			*(draw_pos) = colour;
		}
	}
}

void drawline(int x0, int x1,int y0,int y1,int colour){
	int i;
	int *draw_pos;

	//line (x0,y0) to  (x1, y0)
	for(i = x0;i<x1;i++){
		draw_pos = (int)DDR_FB+(y0<<12)+(i<<2);
		*(draw_pos) = colour;
	}
	//line (x1,y0) to  (x1, y1)
	for(i = y0;i<y1;i++){
		draw_pos = (int)DDR_FB+(i<<12)+(x1<<2);
		*(draw_pos) = colour;
	}
	//line (x0,y1) to  (x1, y1)
	for(i = x0;i<x1;i++){
		draw_pos = (int)DDR_FB+(y1<<12)+(i<<2);
		*(draw_pos) = colour;
	}
	//line (x0,y0) to  (x0, y1)
	for(i = y0;i<y1;i++){
		draw_pos = (int)DDR_FB+(i<<12)+(x0<<2);
		*(draw_pos) = colour;
	}

}



