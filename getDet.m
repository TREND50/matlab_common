function [DetId ChIndex]= getDet(uid,Struct)
% Returns ID of detector + channel index (1..3)
% machine uid belongs to in DST Struct
% OM 27/08/2015

DetId = 0;
ChIndex = 0;

dets = [Struct.Setup.Det];

for i = 1:size(dets,2)
    ch = dets(i).Channels;
    for j = 1:size(ch,2)
        if ch(j).Machine==uid
          ChIndex = j;
          DetId = i;
        end
    end
end
