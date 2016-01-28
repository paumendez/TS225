function [ x2,y2 ] = translation2( A,B)
%%Help
%Fonction qui permet de trouver la translation liant les images A et B
%Entree::
%A,B: les deux images
%Sortie::
%[x2,y2] : Les deux translations selon l'axe des x et des y.

h=length(A(:,1,1));
w=length(A(1,:,1));

TFA=fft2(A(:,:,1)); 
TFB=fft2(B(:,:,1));
%Calcul du spectre croise :
PAB=TFA.*conj(TFB)./(abs(TFA.*conj(TFB)));
pAB=ifft2(PAB);
%On trouve le dirac :
maximum_pAB= max(max(pAB));
[y2,x2]=find(pAB==maximum_pAB);

%On en deduit les translations :
y2=y2-1;
x2=x2-1;

if x2 > w/2
    x2 = x2-w;
end
if y2 > h/2 
    y2 = y2-h ;
end

end
