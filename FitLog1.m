function  [Params fval] = FitLog1(xdata, ydata,start_point,dis)


 function [sse, FittedCurve] = computechi2(params)
   FittedCurve = flog1(params,xdata);
   ErrorVector = FittedCurve - ydata;
   sse = sum(ErrorVector .^ 2);  % This is the residual of fit, transfered as 2nd parameter (fval)
 end

 model = @computechi2;
 if ~exist('start_point','var')
   start_point = [1 1];
 end
 [Params fval] = fminsearch(model, start_point);
 
 %errorbar(xdata, ydata,0,'+')
 %hold('on')  
 if dis
     fplot(@(x)flog(Params,x),[-20 max(xdata)*1.1+0.1],'r')
 end
 %hold('off')

end 


