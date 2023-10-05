#include <gtk/gtk.h>

int count = 0;
GtkWidget *txt;

void copy_text(GtkWidget *wid, gpointer ptr)
{
    const char *input = gtk_entry_get_text(GTK_ENTRY(txt));
    gtk_label_set_text(GTK_LABEL(ptr), input);
}

void end_program(GtkWidget *wid, gpointer ptr)
{
    gtk_main_quit();
}

void count_button(GtkWidget *wid, gpointer ptr)
{
    char buffer[30];
    count++;
    sprintf(buffer, "Button pressed %d times", count);
    gtk_label_set_text(GTK_LABEL(ptr), buffer);
}

int main(int argc, char *argv[])
{
    gtk_init(&argc, &argv);
    GtkWidget *win = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    GtkWidget *btn = gtk_button_new_with_label("Close window");
    GtkWidget *lbl = gtk_label_new("GTK-1");
    GtkWidget *btn2 = gtk_button_new_with_label("Copy button");
    g_signal_connect(btn2, "clicked", G_CALLBACK(copy_text), lbl);

    // txt = gtk_entry_new();
    GtkAdjustment *adj = gtk_adjustment_new(0, -10, 10, 1, 0, 0);
    txt = gtk_spin_button_new(adj, 0, 0);
    
    g_signal_connect(btn2, "clicked", G_CALLBACK(copy_text), lbl);
    g_signal_connect(btn, "clicked", G_CALLBACK(end_program), NULL);
    // If the user clicks X, this signal will also call the end program handler
    g_signal_connect(win, "delete_event", G_CALLBACK(end_program), NULL);

    GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);

    /*
    gtk_box_pack_start (GTK_BOX (box), btn2, TRUE, FALSE, 0);
    gtk_box_pack_start (GTK_BOX (box), lbl, TRUE, FALSE, 0);
    gtk_box_pack_start (GTK_BOX (box), btn, TRUE, TRUE, 0);
    gtk_container_add (GTK_CONTAINER (win), box);
    */

    GtkWidget *grd = gtk_grid_new();
    gtk_grid_attach(GTK_GRID(grd), lbl, 0, 0, 1, 1);
    gtk_grid_attach(GTK_GRID(grd), btn2, 1, 0, 1, 1);
    gtk_grid_attach(GTK_GRID(grd), btn, 0, 1, 1, 1);
    gtk_grid_attach(GTK_GRID(grd), txt, 1, 1, 1, 1);
    gtk_container_add(GTK_CONTAINER(win), grd);
    gtk_widget_show_all(win);
    gtk_main();
    return 0;
}
