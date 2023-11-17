#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <unistd.h>
#include <getopt.h>
#include "gameboard.h"
#include "gameoflife.h"
#include <gtk/gtk.h>

#define GRID_SIZE 64

typedef struct {
    GtkWidget *widget;
    gboolean is_alive;
} Cell;

typedef struct {
    Cell *cells[GRID_SIZE][GRID_SIZE];
    
} AppState;

static gameboard_t *gameboard_1;
static gameboard_t *gameboard_2;
static gameboard_t *temp;
static gameboard_t *current;
static gameboard_t *next;

// Callback function for when the window is closed  
static gboolean on_delete_event(GtkWidget *widget, GdkEvent *event, gpointer data) {
    // Perform any necessary cleanup here
    gtk_main_quit();
    // Return FALSE to destroy the window
    return FALSE;
}

// Callback function for drawing the cell
static gboolean on_draw_event(GtkWidget *widget, cairo_t *cr, gpointer user_data) {
    Cell *cell = (Cell *)user_data;

    if (cell->is_alive) {
        cairo_set_source_rgb(cr, 0, 0, 0); // Black for alive
    } else {
        cairo_set_source_rgb(cr, 1, 1, 1); // White for dead
    }

    cairo_rectangle(cr, 0, 0, 20, 20);
    cairo_fill(cr);

    return FALSE;
}


// Function to update and redraw the grid
static gboolean update_grid(gpointer data) {
    AppState *app_state = (AppState *)data;

    getNextGeneration(current, next);
    temp = current;
    current = next;
    next = temp;
    
    // Redraw each cell
    for (int i = 0; i < GRID_SIZE; i++) {
        for (int j = 0; j < GRID_SIZE; j++) {
            app_state->cells[i][j]->is_alive = getcell(current, i, j);
            gtk_widget_queue_draw(app_state->cells[i][j]->widget);
        }
    }

    return TRUE; // Return TRUE to keep the timer running
}

void activate(GtkApplication* app, gpointer user_data) {
    GtkWidget *window;
    GtkWidget *grid;
    GtkWidget *cell;

    AppState *app_state = g_new0(AppState, 1);
    window = gtk_application_window_new(app);
    g_signal_connect(window, "delete-event", G_CALLBACK(on_delete_event), NULL);
    gtk_window_set_title(GTK_WINDOW(window), "Game of Life");
    gtk_window_set_default_size(GTK_WINDOW(window), 640, 480);

    grid = gtk_grid_new();
    gtk_container_add(GTK_CONTAINER(window), grid);

    
    for (int i = 0; i < GRID_SIZE; i++) {
        for (int j = 0; j < GRID_SIZE; j++) {
            app_state->cells[i][j] = g_new0(Cell, 1);
            app_state->cells[i][j]->widget = gtk_event_box_new();
            app_state->cells[i][j]->is_alive = FALSE; // Initialize as dead

            gtk_widget_set_size_request(app_state->cells[i][j]->widget, 10, 10);
            g_signal_connect(G_OBJECT(app_state->cells[i][j]->widget), "draw", G_CALLBACK(on_draw_event), app_state->cells[i][j]);
            gtk_grid_attach(GTK_GRID(grid), app_state->cells[i][j]->widget, i, j, 1, 1);
        }
    }

    gtk_widget_show_all(window);

    // Set up the timer to update the grid every 100 milliseconds
    g_timeout_add(10, update_grid, app_state);
}

int main(int argc, char **argv)
{
    int width = 64;
    int height = 64;

    int opt;
    char *patternFile = "glidergun.txt"; // Default
    opterr = 0;

    while ((opt = getopt(argc, argv, "x:y:f:")) != -1)
    {
        switch (opt)
        {
        case 'x':
            width = atoi(optarg);
            break;
        case 'y':
            height = atoi(optarg);
            break;
        case 'f':
            patternFile = optarg;
            break;
        default:
            fprintf(stderr, "Usage: %s [-w width] [-h height] [-f patternFile]\n", argv[0]);
            exit(EXIT_FAILURE);
        }
    }
    gameboard_1 = creategameboard(GRID_SIZE, GRID_SIZE);
    gameboard_2 = creategameboard(GRID_SIZE, GRID_SIZE);
    if (gameboard_1 == NULL || gameboard_2 == NULL)
    {
        return -1;
    }

    initgameboard(gameboard_1, CELL_DEAD);
    initgameboard(gameboard_2, CELL_DEAD);

    loadPatternFile(patternFile, gameboard_1, GRID_SIZE/3, GRID_SIZE/3);
 
    current = gameboard_1;
    next = gameboard_2;

    GtkApplication *app;
    int status;

    app = gtk_application_new("com.softcentral.gameoflife", G_APPLICATION_DEFAULT_FLAGS);
    g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);
    status = g_application_run(G_APPLICATION(app), 0, NULL);
    g_object_unref(app);

    return status;
}