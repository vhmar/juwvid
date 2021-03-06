module estif
#import DSP
import cohenclass
import extif
import polywv

function ifestxvwd(z,ynorm,dx,niter,indfn=NaN,isf=NaN,ief=NaN,fin=NaN,tfrsw=false)

    if isnan(fin[1])
        nf=size(z)
    else
        nf=length(fin)
    end

    if isnan(isf) isf=1 end 
    if isnan(ief) ief=nf end 

    if isnan(indfn[1])
        tfrn=cohenclass.tfrwv(z,NaN,NaN,NaN,NaN,1)
        indfn=extif.maxif(real(tfrn),isf,ief)
    end
    
    for it=1:niter        
        zhat=exp(im*cumsum(indfn)*ynorm*dx)
        if isnan(fin[1])
            tfrn=cohenclass.tfrwv(z,zhat,NaN,NaN,NaN,1)
            indfn=extif.maxif(abs(tfrn),isf,ief)
        else
            tfrn=cohenclass.tfrwv(z,zhat,NaN,fin,NaN,0);
            indfna=extif.maxif(abs(tfrn),isf,ief)
            indfn=fin[round(Int,indfna)]
        end
    end

    if tfrsw
        return indfn, tfrn
    else
        return indfn
    end
end

function ifestxpvwd(z,ynorm,dx,niter,indfn=NaN,isf=NaN,ief=NaN,fin=NaN,nwindow=4,tfrsw=false)
    if isnan(fin[1])
        nf=size(z)
    else
        nf=length(fin)
    end

    if isnan(isf) isf=1 end 
    if isnan(ief) ief=nf end 

    if isnan(indfn[1])
        tfrn=cohenclass.tfrpwv(z,NaN,NaN,NaN,NaN,1)
        indfn=extif.maxif(real(tfrn),isf,ief)
    end

    for it=1:niter
        zhat=exp(im*cumsum(indfn*ynorm*dx))
        if isnan(fin[1])
            tfrn=cohenclass.tfrpwv(z,zhat,NaN,NaN,NaN,1,"mean",nwindow)
            indfn=extif.maxif(abs(tfrn),isf,ief)
        else
            tfrn=cohenclass.tfrpwv(z,zhat,NaN,fin,NaN,NaN,0,"mean",nwindow);
            indfna=extif.maxif(abs(tfrn),isf,ief)
            indfn=fin[round(Int,indfna)]
        end

    end

    if tfrsw
        return indfn, tfrn
    else
        return indfn
    end
end

function ifestxpowv(z,ynorm,dx,niter,indfn=NaN,isf=NaN,ief=NaN,fin=NaN,nwindow=4,tfrsw=false)

    if isnan(fin[1])
        nf=size(z)
    else
        nf=length(fin)
    end

    if isnan(isf) isf=1 end 
    if isnan(ief) ief=nf end 

    if isnan(indfn[1])
        tfrn=polywv.tfrpowv(z,NaN,NaN,NaN,NaN,1)
        indfn=extif.maxif(real(tfrn),isf,ief)
    end

    for it=1:niter        
        zhat=exp(im*cumsum(indfn)*ynorm*dx)
        if isnan(fin[1])
            tfrn=polywv.tfrpowv(z,zhat,NaN,NaN,0)
            indfn=extif.maxif(abs(tfrn),isf,ief)
        else
            tfrn=polywv.tfrpowv(z,zhat,NaN,fin,NaN,0)
            indfna=extif.maxif(abs(tfrn),isf,ief)
            indfn=fin[round(Int,indfna)]
        end

    end

    if tfrsw
        return indfn, tfrn
    else
        return indfn
    end
end

end