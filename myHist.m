function [N, C] = myHist( X, nbin, clr, label,magn )

  
  if ~exist('magn')
      magn = 1;
  end
  sX = std( X );
  %K = find( label ~= '\' );
  %fprintf( [ label( K ), ' = %12.5e\n' ], sX );

  bins = [-0.6:0.13:0.6];
  [ N, C ] = hist( X, bins );
%  [ N, C ] = hist( X, nbin );
  dC = 0;
  %mean( diff( C ) );
  nrm = sum( N )*dC;
  dN = sqrt(N);
  %dN = sqrt( N )/nrm;
  %N  = N/nrm;
  %hist( X,C, [ clr, 's' ] )
  %h = findobj(gca,'Type','patch');
  h = errorbar( C, N*magn, dN*magn, 'sk','MarkerFaceColor','k' );
  %set(h,'FaceColor','k','EdgeColor',clr(:))
  %h = plot( C, N*magn, clr );
  %h = semilogy( C, N*magn, clr );

  %if clr(2)~='o'
    %set( h, 'MarkerFaceColor', 'k','MarkerEdgeColor','k');
  %end
  grid on;
  xlabel( label, 'fontSize', 18 );
  set( gca, 'fontSize', 16 );