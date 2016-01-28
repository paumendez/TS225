function [Im_out,B_out,Mn,Ma,Mb]=fusion(A,B,B_A,B_B)

    h=length(A(:,1,1));
    l=length(A(1,:,1));
    
    [tx,ty]=translation2(A,B);
    
    B_B=translate(B_B,tx,ty);
    
    B_out=[min(B_B(1),B_A(1)) min(B_B(2),B_A(2)) max(B_B(3),B_A(3)) max(B_B(4),B_A(4))];
    
    ln=B_out(4)-B_out(2)+1;
    hn=B_out(3)-B_out(1)+1;
    
    Mn=zeros(hn,ln);
    Ma=zeros(hn,ln);
    Mb=zeros(hn,ln);
    
    yag=B_A(1)-B_out(1)+1;
    
    xag=B_A(2)-B_out(2)+1;
    
    ybg=abs(B_B(1)-B_out(1)+1);
    xbg=abs(B_B(2)-B_out(2)+1);
    
    Ma(yag:yag+h-1,xag:xag+l-1)=1;
    Mb(ybg:ybg+h-1,xbg:xbg+l-1)=1;
    
    Mn=Ma+Mb;
    
    Im_A=zeros(hn,ln,3);
    Im_B=zeros(hn,ln,3);
    
    Im_out=zeros(ln,hn,3);
    
    Im_A(yag:yag+h-1,xag:xag+l-1,1:3)=A(1:h,1:l,1:3);
    Im_B(ybg:ybg+h-1,xbg:xbg+l-1,1:3)=B(1:h,1:l,1:3);
    
    for i=1:hn
        for j=1:ln
            if(Mn(i,j)>=1)
                Im_out(i,j,1:3)=(Im_A(i,j,1:3).*Ma(i,j)+Im_B(i,j,1:3).*Mb(i,j))./(Mn(i,j));
            else
                Im_out(i,j,1:3)=zeros(1,1,3);
            end
        end
    end
end
