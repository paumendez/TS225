function [Boite_out]= translate(Boite,tx,ty)
%%Help
%Translate la boite englobante prise en entree par les translations qui
%sont fournies
%Entree::
%Boite: boite englobante que lon souhaite translate 
%tx:translation selon l axe des x
%ty:translation selon l axe des y
%Sortie::
%Boite_out: boite englobante de l image translate par les translation prise
%en entree
Boite_out=[Boite(1)+ty Boite(2)+tx Boite(3)+ty Boite(4)+tx]; 
end
