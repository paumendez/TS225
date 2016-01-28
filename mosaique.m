function [ Im_out,Mn,B_out ] = mosaique(im,h,l,N)
%%Help
%Version de notre programme de creation de mosaique
%Entree::
%im : Vecteur de matrice image
%h : hauteur des images
%l : longueur des images
%N : nombre d'image fournie
%Sortie : Mosaique final fusion de l ensemble des images fournies.

%%
    B=zeros(N,4);
    %on genere les boites englobantes de l'ensemble des images
    for i=1:N
        B(i,:)=generate(im{i});
    end
    
    tx=zeros(1,N);
    ty=zeros(1,N);
    
    tx(1)=0;
    ty(1)=0;
    
    Bn=zeros(N,4);
    Bn(1,:)=B(1,:);
    
    for i=2:N
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
    
    M={};
    
    xg=zeros(1,N);
    yg=zeros(1,N);
    Im_out=zeros(hn,ln,3);
    Im_t={};
    
    for i=1:N
        %calcul des coordonnees du bord haut gauche de chaque image
        yg(i)=Bn(i,1)-B_out(1)+1;
        xg(i)=Bn(i,2)-B_out(2)+1;
        %On calcule le masque de la mosaique 
        M{i}=zeros(hn,ln);
        M{i}(yg(i):yg(i)+h-1,xg(i):xg(i)+l-1)=1;
        Mn=Mn+M{i};
        
        Im_t{i}=zeros(hn,ln,3);
        Im_t{i}(yg(i):yg(i)+h-1,xg(i):xg(i)+l-1,1:3)=im{i}(1:h,1:l,1:3);
    end
    for j=1:hn
        for k=1:ln
            if (Mn(j,k)>=1)
                 %on trouve la mosaique par moyennage
                for i=1:N
                    Im_out(j,k,1:3)=Im_out(j,k,1:3)+Im_t{i}(j,k,1:3).*M{i}(j,k);
                end
                Im_out(j,k,1:3)=Im_out(j,k,1:3)./Mn(j,k);
            else
                Im_out(j,k,1:3)=zeros(1,1,3);
            end
        end
    end
    
end
