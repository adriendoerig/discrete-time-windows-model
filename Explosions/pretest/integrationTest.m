t_max = 2;              % simulation time in seconds
t_stimA = 0.1;     % duration stim A
t_interval = 0.3;  % exploding bars without vernier
t_stimB = 0.1;     % duration stim B
dt = 0.0005;            % time step = 0.5 ms
T = t_max/dt;         % number of time steps. eg. t_max = 2 seconds, dt = 0.0005 s -> 2/0.0005 = 4000 0.5ms steps.
time = dt:dt:T*dt;    

input = zeros(1,t_max/dt);
input(1:t_stimA/dt) = 1;
input(t_stimA/dt:(t_stimA+t_interval)/dt) = 0;
input((t_stimA+t_interval)/dt:(t_stimA+t_interval+t_stimB)/dt) = -1;

E = zeros(1,t_max/dt);
tau = .1;

for t=1:T-1
    E(t+1) = E(t)*(1-dt/tau) + input(t)*dt;
end

plot(time,E)