
#define DISPLAY_COLUMNS  640
#define DISPLAY_ROWS     480

//Frame buffer in DDR
volatile unsigned int * DDR_FB = (unsigned int *)0x80400000;

//display buffer in DDR
//volatile unsigned int * DDR_DB = (unsigned int *)0x80400000;




//tracking
volatile unsigned int * TK_BS = (unsigned int *)0x44A20000;//control
volatile unsigned int * TK_RF = (unsigned int *)0x44A20004;//reference
volatile unsigned int * TK_TH = (unsigned int *)0x44A20008;//thershold
volatile unsigned int * TK_ST = (unsigned int *)0x44A2000c;//status
volatile unsigned int * TK_XP = (unsigned int *)0x44A20010;//X pos
volatile unsigned int * TK_YP = (unsigned int *)0x44A20014;//Y_pos

void TrackingInit(int ref, int th)
{
	*(TK_RF) = ref;
	*(TK_TH) = th;
}

void TrackingRun()
{
	*(TK_BS) = 0x1;
}


//VDMA
volatile unsigned int * VDMA_BS = (unsigned int *)0x44A10000;//baseaddress
volatile unsigned int * VDMA_CR = (unsigned int *)0x44A10030;//control for the s2mm
volatile unsigned int * VDMA_AD = (unsigned int *)0x44A100AC;//Address tie store the pixel
volatile unsigned int * VDMA_ST = (unsigned int *)0x44A100A8;//stride(larger than 4*640)
volatile unsigned int * VDMA_HS = (unsigned int *)0x44A100A4;//Hori size in byte
volatile unsigned int * VDMA_VS = (unsigned int *)0x44A100A0;//vertical size in line

void VDMAInit(unsigned int * buffer)
{
	*(VDMA_AD) = (int )buffer;
	*(VDMA_ST) = 4096;
	*(VDMA_HS) = 4*DISPLAY_COLUMNS;
}
void VDMAStart()
{
	*(VDMA_CR) = 0x1;
	*(VDMA_VS) = DISPLAY_ROWS;
}
void VDMAStop()
{
	*(VDMA_CR) = 0x0;
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
	for(i = -10;i<10;i++){
		for(j = -10; j<10;j++){
			draw_pos = (int)DDR_FB + ((y+i)<<12) + ((x+j)<<2);
			*(draw_pos) = colour;
		}
	}
}

/*void copy_to_DB(){
	int y, x;
	int *draw_pos;
	int *source;
	int pixel;
	for(y=0;y<480;y++){
		for(x=0;x<640;x++){
			draw_pos = DDR_DB + ((y)<<12) + ((x)<<2);
			source = DDR_FB + ((y)<<12) + ((x)<<2);
			pixel= *(source);
			*(draw_pos)= pixel;

		}
	}
}
*/

