/*
 *  George Papanikolaou - Prokopis Gryllos
 *  This is the preprocessor for the Buzen compiler
 *  CEID Project 2011-2012
 */

// Basic headers:
#include <stdio.h>
#include <stdlib.h>

// Declaration of boolean type
typedef enum { false, true } bool;

int main (int argc, char **argv) {
    /* ===> FILE declarations <=== */
    FILE *source, *final;

    if (argc != 2) {
        printf("Please give only the name of the file\n");
        exit(EXIT_FAILURE);
    }

    int counter = 0;
    char *source_name = argv[1];    // Names of the files
    char *final_name  ="new_copy";
    int ch;                         // Character to test.
    bool in_comment = false;        // Boolean flag ( defaults to false )
    /*  Assigning streams of the files  */
    source = fopen(source_name, "r");
    final = fopen(final_name, "w");

    if (source == NULL || final == NULL) {
        /* Did the files open correctly? */
        printf("Failed to open files\n");
        exit(EXIT_FAILURE);
    }
    ch = fgetc(source);
    /* ========== Starting parsing ========== */
    while (ch != EOF) {
        if (ch == '/') {
            ch = fgetc(source);
            if (ch == '*') {
                in_comment = true;
                ch = fgetc(source);
            }
            else {
                if (in_comment == false) {
                    fputc('/', final);
                    /* Placing the missing `/` */
                }
            }
        }
        if (ch == '*') {
            ch = fgetc(source);
            if (ch == '/') {
                in_comment = false;
                ch = fgetc(source);
            }
            else {
                if (in_comment == false) {
                    fputc('*', final);
                    /* Placing the missing `*` */
                }
            }
        }

        if (in_comment == false) {
            /* Actually copying the character if we are inside a comment */
            fputc(ch, final);
            counter++;
        }

        /*   Next Character please...  */
        ch = fgetc(source);
    }
    printf("Completed: %d characters.\n", counter);
    fclose(source);
    fclose(final);
    return 0;
}
