function [ Im_out] = mosaique3( im,h,l,N )
%%Help
%Derniere version de notre programme de creation de mosaique
%Entree::
%im : Vecteur de matrice image
%h : hauteur des images
%l : longueur des images
%N : nombre d'image fournie
%Sortie : Mosaique final fusion de l ensemble des images fournies.
%%
    B=zeros(N,4);
    B(1,:)=generate(im{1});
    tx=zeros(1,N);
    ty=zeros(1,N);
    tx(1)=0;
    ty(1)=0;
    Bn=zeros(N,4);
    Bn(1,:)=B(1,:);
    for i=2:N
       %on genere les boites englobantes de l'ensemble des images
       B(i,:)=generate(im{i});
       %on trouve les translation qui lient les images entre elles
       [tx(i),ty(i)]=translation2(im{i-1},im{i});
       %on translate les boites englobantes les unes par rapport aux autres
       Bn(i,:)=translate(Bn(i-1,:),tx(i),ty(i));
    end
    %Boite englobante de la mosaique
    B_out=[min(Bn(:,1)) min(Bn(:,2)) max(Bn(:,3)) max(Bn(:,4))];
    %longeur et hauteur de la mosaique
    ln=B_out(4)-B_out(2)+1;
    hn=B_out(3)-B_out(1)+1;
    
    Mn=zeros(hn,ln);
    
    xg=zeros(1,N);
    yg=zeros(1,N);
    Im_out=zeros(hn,ln);
    
    for i=1:N
        %calcul des coordonnees du bord haut gauche de chaque image
        yg(i)=Bn(i,1)-B_out(1)+1;
        xg(i)=Bn(i,2)-B_out(2)+1;
        %On calcule le masque de la mosaique 
        M=zeros(hn,ln);
        M(yg(i):yg(i)+h-1,xg(i):xg(i)+l-1)=1;
        Mn=Mn+M;
        %on trouve la mosaique par moyennage
        Im_t=zeros(hn,ln);
        Im_t(yg(i):yg(i)+h-1,xg(i):xg(i)+l-1)=im{i}(1:h,1:l);
        Im_out=Im_out+Im_t.*M;   
    end
    Mt=(Mn==0);
    Mn=Mn+Mt;
   
    Im_out=Im_out./Mn;

end
