function a = vector_vector_angle2d(v1,v2,type,rd)
%%  vector_vector_angle2d - calculates angle between 2D vectors
%
%   INPUT:
%       v1,v2   - vectors,
%       type    - 0 -> [-PI PI]; 1 -> [0 PI]; 2 -> [0 2PI],
%       rd      - 1 -> degree.
%
%   OUTPUT:
%       a       - angle
%
%   HELP:
%       [0 2PI] -> [0 PI]  =>  a = 180 - mod(a,180)
%       In 3D: a = atan2(norm(cross(v1,v2)),dot(v1,v2));
%
%   AUTHOR:
%       Boguslaw Obara

%% setup
if nargin<4; rd = 0;    end
if nargin<3; type = 0;  end

%% calculate angle
if type==0 % full [-PI PI]
    a = atan2(det([v1',v2']),dot(v1',v2'));
elseif type==1 % full [0 PI]
    a = abs(atan2(det([v1',v2']),dot(v1',v2')));
elseif type==2 % full [0 2PI]
    a = mod(atan2(det([v1',v2']),dot(v1',v2')),2*pi); 
end
if rd==1 % degree
    a = (a*180.0)/pi; 
end
if isnan(a); a = 0; end

end