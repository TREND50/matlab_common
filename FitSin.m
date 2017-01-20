function  [Params fval] = FitSin(xdata, ydata,start_point,dis)
% Fonction qui fitte par une sinusoide
%         Params(1) = amplitude
%         Params(2) = freq
%         Params(2) = phase


 function [sse, FittedCurve] = computechi2(params)
   FittedCurve = fsin(params,xdata);
   ErrorVector = FittedCurve - ydata;
   sse = sum(ErrorVector .^ 2);  % This is the residual of fit, transfered as 2nd parameter (fval)
 end

 model = @computechi2;
 if ~exist('start_point','var')
   start_point = [1 10e6 0];
 end
 [Params fval] = fminsearch(model, start_point);
 %Params = start_point
 %errorbar(xdata, ydata,0,'+')
 %hold('on')  
 %if dis
 %    fplot(@(x)fsin(Params,x),[0 max(xdata)*1.1+0.1],'g')
 %end
 %hold('off')

end 


