# include "Grapic.h"

using namespace grapic;

int main(void)
{
     winInit("Won", 500, 500);   // Créer une fenêtre (taille 500x500)     
     winClear();                    // Efface la fenêtre     
     color(255, 0, 0);
     line( 10, 0, 10, 499);           // Dessine une ligne verticale en x=10     
     rectangle(10, 10, 100, 100);
     winDisplay();                    // Affiche réellement à l’écran     
     pressSpace();                    // Attend l’appui sur « espace » pour fermer
     winQuit();                      // Ferme la fenêtre et quitte     
     return 0;
} 
