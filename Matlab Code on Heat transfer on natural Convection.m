

title('Temperature Distribution in H-Shaped Cavity');
% Parameters
L = 1; % Length of cavity
W = 1; % Width of cavity
H = 0.1; % Height of cavity
T_hot = 100; % Temperature of hot wall
T_cold = 0; % Temperature of cold walls
nx = 51; % Number of grid points in x-direction
ny = 51; % Number of grid points in y-direction
dx = L/(nx-1); % Grid spacing in x-direction
dy = W/(ny-1); % Grid spacing in y-direction
max_iter = 1000; % Maximum number of iterations
tolerance = 1e-5; % Convergence tolerance

% Initialization
T = ones(nx, ny) * T_cold; % Initialize temperature array

% Main loop (iterate until convergence)
for iter = 1:max_iter
    % Boundary conditions
    T(:,1) = T_cold; % Left cold wall
    T(:,end) = T_cold; % Right cold wall
    T(1,:) = T_hot; % Hot wall
    
    % Compute temperature field using simple averaging
    T_new = T;
    for i = 2:nx-1
        for j = 2:ny-1
            % Average of neighboring points
            T_new(i,j) = 0.25*(T(i+1,j) + T(i-1,j) + T(i,j+1) + T(i,j-1));
        end
    end
    
    % Check for convergence
    if max(abs(T_new(:) - T(:))) < tolerance
        disp(['Converged at iteration ', num2str(iter)]);
        break;
    end
    
    % Update temperature array
    T = T_new;
end

% Plotting the results
[X, Y] = meshgrid(linspace(0,L,nx), linspace(0,W,ny));
contourf(X, Y, T', 50, 'LineColor', 'none');
colorbar;
xlabel('x');
ylabel('y');