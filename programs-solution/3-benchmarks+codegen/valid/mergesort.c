#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
char *my_itoa(int a){ char *tmp=malloc(16); sprintf(tmp, "%d", a); return tmp;}
char *ftoa(double a){ char *tmp = malloc(32); sprintf(tmp, "%+1.6e", a); return tmp;}
char *ctoa(char a){ char *tmp = malloc(2); tmp[0] = a; tmp[1] = '\0'; return tmp;}
struct CODEGEN_BINDING2 {
	int size;
	int cap;
	int *val;
};
void CODEGEN_BINDING0merge_sort(struct CODEGEN_BINDING2 CODEGEN_BINDING1array, int CODEGEN_BINDING3length);
void CODEGEN_BINDING4merge_sort_helper(struct CODEGEN_BINDING2 CODEGEN_BINDING5array, struct CODEGEN_BINDING2 CODEGEN_BINDING6temp, int CODEGEN_BINDING7lo, int CODEGEN_BINDING8hi);
void CODEGEN_BINDING9merge(struct CODEGEN_BINDING2 CODEGEN_BINDING10array, struct CODEGEN_BINDING2 CODEGEN_BINDING11temp, int CODEGEN_BINDING12lo, int CODEGEN_BINDING13hi);
void CODEGEN_BINDING9merge(struct CODEGEN_BINDING2 CODEGEN_BINDING10array, struct CODEGEN_BINDING2 CODEGEN_BINDING11temp, int CODEGEN_BINDING12lo, int CODEGEN_BINDING13hi){
	int CODEGEN_BINDING14 = (CODEGEN_BINDING12lo+CODEGEN_BINDING13hi)/2;
int CODEGEN_BINDING15mid = CODEGEN_BINDING14;
	int CODEGEN_BINDING16 = CODEGEN_BINDING12lo;
int CODEGEN_BINDING17temp_index = CODEGEN_BINDING16;
	int CODEGEN_BINDING18 = CODEGEN_BINDING12lo;
int CODEGEN_BINDING19index_left = CODEGEN_BINDING18;
	int CODEGEN_BINDING20 = CODEGEN_BINDING15mid+1;
int CODEGEN_BINDING21index_right = CODEGEN_BINDING20;
	while(CODEGEN_BINDING19index_left<=CODEGEN_BINDING15mid&&CODEGEN_BINDING21index_right<=CODEGEN_BINDING13hi){
		{
			int CODEGEN_BINDING22 = CODEGEN_BINDING21index_right; if(CODEGEN_BINDING10array.size <= CODEGEN_BINDING22){fprintf(stderr, "Access out of range.\n"); exit(1);}
			int CODEGEN_BINDING23 = CODEGEN_BINDING19index_left; if(CODEGEN_BINDING10array.size <= CODEGEN_BINDING23){fprintf(stderr, "Access out of range.\n"); exit(1);}
			if ((CODEGEN_BINDING10array.val[CODEGEN_BINDING23]<CODEGEN_BINDING10array.val[CODEGEN_BINDING22])){
				int CODEGEN_BINDING24 = CODEGEN_BINDING19index_left; if(CODEGEN_BINDING10array.size <= CODEGEN_BINDING24){fprintf(stderr, "Access out of range.\n"); exit(1);}
				int CODEGEN_BINDING25 = CODEGEN_BINDING17temp_index; if(CODEGEN_BINDING11temp.size <= CODEGEN_BINDING25){fprintf(stderr, "Access out of range.\n"); exit(1);}
				int CODEGEN_BINDING26 = CODEGEN_BINDING10array.val[CODEGEN_BINDING24];
				CODEGEN_BINDING11temp.val[CODEGEN_BINDING25] = CODEGEN_BINDING26;
				CODEGEN_BINDING19index_left++;
			}
else{
				int CODEGEN_BINDING27 = CODEGEN_BINDING21index_right; if(CODEGEN_BINDING10array.size <= CODEGEN_BINDING27){fprintf(stderr, "Access out of range.\n"); exit(1);}
				int CODEGEN_BINDING28 = CODEGEN_BINDING17temp_index; if(CODEGEN_BINDING11temp.size <= CODEGEN_BINDING28){fprintf(stderr, "Access out of range.\n"); exit(1);}
				int CODEGEN_BINDING29 = CODEGEN_BINDING10array.val[CODEGEN_BINDING27];
				CODEGEN_BINDING11temp.val[CODEGEN_BINDING28] = CODEGEN_BINDING29;
				CODEGEN_BINDING21index_right++;
			}
		}
		CODEGEN_BINDING17temp_index++;
		continue;
	}
	while(CODEGEN_BINDING21index_right<=CODEGEN_BINDING13hi){
		int CODEGEN_BINDING30 = CODEGEN_BINDING21index_right; if(CODEGEN_BINDING10array.size <= CODEGEN_BINDING30){fprintf(stderr, "Access out of range.\n"); exit(1);}
		int CODEGEN_BINDING31 = CODEGEN_BINDING17temp_index; if(CODEGEN_BINDING11temp.size <= CODEGEN_BINDING31){fprintf(stderr, "Access out of range.\n"); exit(1);}
		int CODEGEN_BINDING32 = CODEGEN_BINDING10array.val[CODEGEN_BINDING30];
		CODEGEN_BINDING11temp.val[CODEGEN_BINDING31] = CODEGEN_BINDING32;
		CODEGEN_BINDING21index_right++;
		CODEGEN_BINDING17temp_index++;
		continue;
	}
	while(CODEGEN_BINDING19index_left<=CODEGEN_BINDING15mid){
		int CODEGEN_BINDING33 = CODEGEN_BINDING19index_left; if(CODEGEN_BINDING10array.size <= CODEGEN_BINDING33){fprintf(stderr, "Access out of range.\n"); exit(1);}
		int CODEGEN_BINDING34 = CODEGEN_BINDING17temp_index; if(CODEGEN_BINDING11temp.size <= CODEGEN_BINDING34){fprintf(stderr, "Access out of range.\n"); exit(1);}
		int CODEGEN_BINDING35 = CODEGEN_BINDING10array.val[CODEGEN_BINDING33];
		CODEGEN_BINDING11temp.val[CODEGEN_BINDING34] = CODEGEN_BINDING35;
		CODEGEN_BINDING19index_left++;
		CODEGEN_BINDING17temp_index++;
		continue;
	}
	{
				int CODEGEN_BINDING36 = CODEGEN_BINDING12lo;
int CODEGEN_BINDING37i = CODEGEN_BINDING36;
		while (CODEGEN_BINDING37i<=CODEGEN_BINDING13hi){
			int CODEGEN_BINDING38 = CODEGEN_BINDING37i; if(CODEGEN_BINDING11temp.size <= CODEGEN_BINDING38){fprintf(stderr, "Access out of range.\n"); exit(1);}
			int CODEGEN_BINDING39 = CODEGEN_BINDING37i; if(CODEGEN_BINDING10array.size <= CODEGEN_BINDING39){fprintf(stderr, "Access out of range.\n"); exit(1);}
			int CODEGEN_BINDING40 = CODEGEN_BINDING11temp.val[CODEGEN_BINDING38];
			CODEGEN_BINDING10array.val[CODEGEN_BINDING39] = CODEGEN_BINDING40;
		CODEGEN_BINDING37i++;
			continue;
		CODEGEN_BINDING37i++;
		}
	}
}
void CODEGEN_BINDING4merge_sort_helper(struct CODEGEN_BINDING2 CODEGEN_BINDING5array, struct CODEGEN_BINDING2 CODEGEN_BINDING6temp, int CODEGEN_BINDING7lo, int CODEGEN_BINDING8hi){
	{
		if ((CODEGEN_BINDING7lo>=CODEGEN_BINDING8hi)){
			return;
		}
	}
	int CODEGEN_BINDING41 = (CODEGEN_BINDING7lo+CODEGEN_BINDING8hi)/2;
int CODEGEN_BINDING42mid = CODEGEN_BINDING41;
CODEGEN_BINDING4merge_sort_helper(CODEGEN_BINDING5array, CODEGEN_BINDING6temp, CODEGEN_BINDING7lo, CODEGEN_BINDING42mid);CODEGEN_BINDING4merge_sort_helper(CODEGEN_BINDING5array, CODEGEN_BINDING6temp, CODEGEN_BINDING42mid+1, CODEGEN_BINDING8hi);CODEGEN_BINDING9merge(CODEGEN_BINDING5array, CODEGEN_BINDING6temp, CODEGEN_BINDING7lo, CODEGEN_BINDING8hi);}
void CODEGEN_BINDING0merge_sort(struct CODEGEN_BINDING2 CODEGEN_BINDING1array, int CODEGEN_BINDING3length){
	struct CODEGEN_BINDING2 CODEGEN_BINDING43temp;
	CODEGEN_BINDING43temp.size = 0; CODEGEN_BINDING43temp.cap = 0;
	CODEGEN_BINDING43temp.val = NULL; 
	{
				int CODEGEN_BINDING44 = 0;
int CODEGEN_BINDING45i = CODEGEN_BINDING44;
		while (CODEGEN_BINDING45i<CODEGEN_BINDING3length){
			int CODEGEN_BINDING46 = CODEGEN_BINDING45i; if(CODEGEN_BINDING1array.size <= CODEGEN_BINDING46){fprintf(stderr, "Access out of range.\n"); exit(1);}
			struct CODEGEN_BINDING2 CODEGEN_BINDING47;
			CODEGEN_BINDING47.size = CODEGEN_BINDING43temp.size + 1;
			if (CODEGEN_BINDING43temp.size+1 > CODEGEN_BINDING43temp.cap){
				if(CODEGEN_BINDING43temp.cap == 0) CODEGEN_BINDING47.cap = 2;
				else CODEGEN_BINDING47.cap = CODEGEN_BINDING43temp.cap*2;
			CODEGEN_BINDING47.val = malloc(sizeof(int)*CODEGEN_BINDING47.cap);
			}
			else{ CODEGEN_BINDING47.cap = CODEGEN_BINDING43temp.cap; CODEGEN_BINDING47.val = CODEGEN_BINDING43temp.val;}
			for( int codegen_i = 0; codegen_i < CODEGEN_BINDING43temp.cap; codegen_i++){
				CODEGEN_BINDING47.val[codegen_i] = CODEGEN_BINDING43temp.val[codegen_i];
			}
CODEGEN_BINDING47.val[CODEGEN_BINDING47.size-1] = CODEGEN_BINDING1array.val[CODEGEN_BINDING46];
struct CODEGEN_BINDING2 CODEGEN_BINDING48 = CODEGEN_BINDING47;
			CODEGEN_BINDING43temp.val = CODEGEN_BINDING48.val; 
			CODEGEN_BINDING43temp.size = CODEGEN_BINDING48.size; 
			CODEGEN_BINDING43temp.cap = CODEGEN_BINDING48.cap; 
		CODEGEN_BINDING45i++;
			continue;
		CODEGEN_BINDING45i++;
		}
	}
CODEGEN_BINDING4merge_sort_helper(CODEGEN_BINDING1array, CODEGEN_BINDING43temp, 0, CODEGEN_BINDING3length-1);}
void main(){
	struct CODEGEN_BINDING2 CODEGEN_BINDING49array;
	CODEGEN_BINDING49array.size = 0; CODEGEN_BINDING49array.cap = 0;
	CODEGEN_BINDING49array.val = NULL; 
	int CODEGEN_BINDING50 = 10000000;
int CODEGEN_BINDING51length = CODEGEN_BINDING50;
	{
				int CODEGEN_BINDING52 = 0;
int CODEGEN_BINDING53i = CODEGEN_BINDING52;
		while (CODEGEN_BINDING53i<CODEGEN_BINDING51length){
			struct CODEGEN_BINDING2 CODEGEN_BINDING54;
			CODEGEN_BINDING54.size = CODEGEN_BINDING49array.size + 1;
			if (CODEGEN_BINDING49array.size+1 > CODEGEN_BINDING49array.cap){
				if(CODEGEN_BINDING49array.cap == 0) CODEGEN_BINDING54.cap = 2;
				else CODEGEN_BINDING54.cap = CODEGEN_BINDING49array.cap*2;
			CODEGEN_BINDING54.val = malloc(sizeof(int)*CODEGEN_BINDING54.cap);
			}
			else{ CODEGEN_BINDING54.cap = CODEGEN_BINDING49array.cap; CODEGEN_BINDING54.val = CODEGEN_BINDING49array.val;}
			for( int codegen_i = 0; codegen_i < CODEGEN_BINDING49array.cap; codegen_i++){
				CODEGEN_BINDING54.val[codegen_i] = CODEGEN_BINDING49array.val[codegen_i];
			}
CODEGEN_BINDING54.val[CODEGEN_BINDING54.size-1] = CODEGEN_BINDING51length-CODEGEN_BINDING53i-1;
struct CODEGEN_BINDING2 CODEGEN_BINDING55 = CODEGEN_BINDING54;
			CODEGEN_BINDING49array.val = CODEGEN_BINDING55.val; 
			CODEGEN_BINDING49array.size = CODEGEN_BINDING55.size; 
			CODEGEN_BINDING49array.cap = CODEGEN_BINDING55.cap; 
		CODEGEN_BINDING53i++;
			continue;
		CODEGEN_BINDING53i++;
		}
	}
CODEGEN_BINDING0merge_sort(CODEGEN_BINDING49array, CODEGEN_BINDING51length);	{
				int CODEGEN_BINDING56 = 0;
int CODEGEN_BINDING57i = CODEGEN_BINDING56;
		while (CODEGEN_BINDING57i<10){
			int CODEGEN_BINDING58 = CODEGEN_BINDING57i; if(CODEGEN_BINDING49array.size <= CODEGEN_BINDING58){fprintf(stderr, "Access out of range.\n"); exit(1);}
			printf("%d",CODEGEN_BINDING49array.val[CODEGEN_BINDING58]); 
			printf("\n");
		CODEGEN_BINDING57i++;
			continue;
		CODEGEN_BINDING57i++;
		}
	}
}
