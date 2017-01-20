function elev = getElevation(x,y)
% Returns elevation at position (x,y)
% Based on GeoTools.z function by Valentin.
% OMH 18/09/09

% Comments by Valentin
% //  The surface point z = f( x, y ) is computed from a 2D polynomial interpolation over the mesh _z, as:
% //
% //  zi( xi, yi ) = hx*hy*z( x, y ) + ( 1 - hx )*hy*z( x+dx, y ) + hx*( 1 - hy )*z( x, y+dy ) + 
% //                 ( 1 - hx )*( 1 - hy )*z( x+dx, y+dy )
% //
% //  where xi, yi, zi are the coordinates interpolated from the surrounding mesh points ( x, y ), ( x+dx, y ),
% //  ( x, y+dy ) and ( x+dx, y+dy ). The reduced coordinates are hx = ( xi  - x )/dx and hy = ( yi - y )/dy.
% //
% //  02/09/2008: If out of range indexes the z surf is bounded by rocks. This is to ensure compatibility with
% //  back propagation algorithm;

   for i=1:length(x)
     [xi,yi,zi] = getMap('map.bin',[x(i)-101,x(i)+101,y(i)-101,y(i)+101]);     
     elev(i) = interp2(xi,yi,zi,x(i),y(i));
     
%      if find(xi==x(i)) & find(yi==y(i))  % This is a position sampled in map.bin
%            elev(i) = zi(find(yi==y(i)),find(xi==x(i)));
%      else   
%         dx = xi(2)-xi(1);
%         dy = yi(2)-yi(1);
%         hx = (xi(2) - x(i))/dx;
%         hy = (yi(2) - y(i))/dy;
%         elev(i) = hx*hy*zi(1,1)+(1-hx)*hy*zi(1,2)+hx*(1-hy)*zi(2,1)+(1-hx)*(1-hy)*zi(2,2);
%      end
   
   end
   