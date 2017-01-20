function  [Params fval] = FitLin(xdata, ydata,start_point,dis)
% Fonction qui fitte par une sinusoide
%         Params(1) = amplitude
%         Params(2) = freq
%         Params(2) = phase


 function [sse, FittedCurve] = computechi2(params)
   FittedCurve = flin(params,xdata);
   ErrorVector = FittedCurve - ydata;
   sse = sum(ErrorVector .^ 2);  % This is the residual of fit, transfered as 2nd parameter (fval)
 end

 model = @computechi2;
 if ~exist('start_point','var')
   start_point = [1 0];
 end
 [Params fval] = fminsearch(model, start_point);
 
 %errorbar(xdata, ydata,0,'+')
 %hold('on')  
 if dis
     fplot(@(x)flin(Params,x),[-20 max(xdata)*1.1+0.1],'r')
 end
 %hold('off')

end 


