function  [Params fval] = FitInvert(xdata, ydata,start_point)
% Fonction qui fitte par une loi inverse
%         Params(1) = E0

 function [sse, FittedCurve] = computechi2(params)
   FittedCurve = finv(params,xdata);
   ErrorVector = FittedCurve - ydata;
   sse = sum(ErrorVector .^ 2);
 end

 model = @computechi2;
 if ~exist('start_point','var')
   start_point = [100];
 end
 [Params fval] = fminsearch(model, start_point);

 %errorbar(xdata, ydata,0,'+')
 %hold('on')  
 %fplot(@(x)finv(Params,x),[0 max(xdata)*1.3],'r')
 %hold('off')

end 


