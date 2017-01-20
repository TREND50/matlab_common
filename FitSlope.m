function  [Params fval] = FitSlope(xdata, ydata,start_point,dis)
% Fonction qui fitte par une droite
%         Params(1) = slope

 function [sse, FittedCurve] = computechi2(params)
   FittedCurve = fslope(params,xdata);
   ErrorVector = FittedCurve - ydata;
   sse = sum(ErrorVector .^ 2);  % This is the residual of fit, transfered as 2nd parameter (fval)
 end

 model = @computechi2;
 if ~exist('start_point','var')
   start_point = 1;
 end
 [Params fval] = fminsearch(model, start_point);
 
 %errorbar(xdata, ydata,0,'+')
 %hold('on')  
 if dis
     fplot(@(x)fslope(Params,x),[-20 max(xdata)*1.1+0.1],'r')
 end
 %hold('off')

end 


