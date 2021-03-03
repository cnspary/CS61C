#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node* head) {
    /* your code here */
    if (head == NULL)
        return 0;
    node* slower = head;
    node* faster = head->next;

    while (faster != NULL) {
        if (slower == faster) {
            return 1;
        }

        slower = slower->next;
        faster = faster->next;

        if (faster)
            faster = faster->next;
    }

    return 0;
}