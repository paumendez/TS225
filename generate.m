function [Boite,Masque]=generate(A)
%%Help
%Fonction qui renvoie la boite englobante et le masque de la fonction prise
%en entree
%Entree::
%A: image concerne 
%Sortie::
%Boite : boite englobante de l image prise en entree
%Masque : Masque de l image prise en entree
long=length(A(:,1,1));
haut=length(A(1,:,1));
Masque=zeros(long,haut);
Boite=[1 1 long haut];
end 
