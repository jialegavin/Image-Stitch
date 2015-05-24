function putTogether(Imws)
nImages=length(Imws);
ImWarp=Imws{1};
for i=2:nImages
    Imw=Imws{i};
     [height width ~]=size(Imw);
            mask1=zeros(height,width,3);
            mask2=zeros(height,width,3);
            mask=zeros(height,width,3);
            mask1(Imw>0)=1;
            mask=mask1;
            mask2(ImWarp>0)=1;
            mask1(mask2>0)=1;
            mask1(mask2>0)=0;
            mask(mask1>0)=0;
%              mask1=zeros(height,width,3);
%               mask1(Imw>0)=1;
              
%             mask=mask1;
%             mask(mask2>0)=1;
%             [e lap]=getOverlap(ImWarp,Imw);
              I1=Imw.*mask;
              I2=ImWarp.*mask;
              I1m=mean(mean(mean(Imw(mask>0))));
              I2m=mean(mean(mean(ImWarp(mask>0))));
              [g1 g2]=findGain(I1m,I2m);
              Imw=Imw*g1;
              ImWarp=ImWarp*g2;
              ImWarp=max(ImWarp,Imw);
%                 ImWarp(Imw>0)=Imw(Imw>0);
%               Imw2=Imw;
%               Imw(mask2>0)=ImWarp(mask2>0);
%               ImWarp=Imw;
%               Imw=Imw2;
%               ImWarp(mask1>0)=Imw2(mask1>0);
%                 imax=0;imin=height;
%                 jmax=0;jmin=width;
%                 for i=1:height
%                     for j=1:width
%                         if(Imw(i,j,1)>0&&ImWarp(i,j,1)>0)
%                             mask(i,j,:)=1;
%                             if(imax<i) imax=i; end
%                             if(imin>i) imin=i; end
%                             if(jmax<j) jmax=j; end
%                             if(jmin>j) jmin=j; end
%                         end
%                     end
%                 end
%              Imw2=Imw.*mask;
%              Imw3=ImWarp.*mask;
%              Imw(mask>0)=0;
%              ImWarp(mask>0)=0;
            
%            mask(Imw>0&&ImWarp>0)=1;
%             mask_size(1)=imax-imin;
%             mask_size(2)=jmax-jmin;
%             mask(imin:imax,jmin:jmax)=1;
%             ImWarp=ImWarp*e;
%             ImWarp2=mblend(Imw,ImWarp,mask,10);
%             ImWarp = max(ImWarp, Imw);
%             ImWarp=max(ImWarp,Imw);
%             [myh myw ~]=size(ImWarp);
%             for mi=1:myh
%                 for nj=1:myw
%                     if(Imw(mi,nj,1)>0||Imw(mi,nj,2)>0||Imw(mi,nj,3)>0)
%                         ImWarp(mi,nj,:)=Imw(mi,nj,:);
%                     end
%                 end
%             end
        end
 ImWarp = ImWarp / 255;
    [height width ~]=size(ImWarp);
    imax=0;imin=height;
    jmax=0;jmin=width;
    for i=1:height
        for j=1:width
            if(ImWarp(i,j,1)>0)
                if(imax<i) imax=i; end
                if(imin>i) imin=i; end
                if(jmax<j) jmax=j; end
                if(jmin>j) jmin=j; end
            end
        end
    end
        ImNew=ImWarp(imin:imax,jmin:jmax,:);
    figure, imagesc(ImNew);

end
