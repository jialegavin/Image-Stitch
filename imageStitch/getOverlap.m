function [e lap]=getOverlap(I1,I2)
[height width ~]=size(I1);
index=1;
amp=0;
for i=1:height
    for j=1:width
        if(I1(i,j,1)>0&&I2(i,j,1)>0&&I1(i,j,2)>0&&I2(i,j,2)>0&&I1(i,j,3)>0&&I2(i,j,3)>0)
            lap(index,1)=i;
            lap(index,2)=j;
            index=index+1;
            tamp=(I2(i,j,1)/I1(i,j,1)+I2(i,j,2)/I1(i,j,2)+I2(i,j,3)/I1(i,j,3))/3;
            amp=amp+tamp;
        end
    end
end
amp=amp/length(lap(:,1));
e=amp;

