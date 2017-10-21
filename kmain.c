/*
*  kmain.c
*/

// Video memory begins here
char *vidptr = (char*)0xb8000;

// there are 25 lines each of 80 columns
// each character takes up two bytes
// first byte for character and second byte is an attribute byte for bg+fg color
const unsigned int vid_line_length = 80;
const unsigned int vid_line_count = 25;
const unsigned int vid_char_count = 80 * 25;

void
clear (void){
    for (unsigned int i=0; i < 2 * vid_char_count; i += 2){
        vidptr[i] = ' ';
        vidptr[i+1] = 0x07; // attribute-byte: light grey fg + black bg
    }
}

void
print (const char* str){
    unsigned int str_i = 0;
    unsigned int vid_i = 0;
    // this loop writes the string to video memory
    while(str[str_i] != '\0') {
        vidptr[vid_i] = str[str_i]; // the character's ascii
        vidptr[vid_i+1] = 0x07; // attribute-byte: light grey fg + black bg
        str_i += 1;
        vid_i = str_i*2;
    }
}

void kmain(void)
{
    const char *str = "Hello World!";

    clear();
    print(str);

    return;
}
