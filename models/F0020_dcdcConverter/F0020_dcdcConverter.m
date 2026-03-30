function [eta, I_bus, P_bus, Q_gen] = F0020_dcdcConverter(U_bus, U_s, I, par)
% Function for the DC-DC converter connected to a DC-bus. The system
% connected to the converter can be either a consumer or a producer.
% Negative current, I, means that the connected device is a consumer from
% the DC-bus and a positive current means that the connected device is a
% producer to the DC-bus.


% Output:
% - eta: Voltage change efficiency
% - I_bus: Current to and from the DC Bus.
% - P_bus: Power to and from the DC Bus
% - P_loss: Converting loss, always positive.
% Inputs:
% - U_bus: DC Bus Voltage
% - U_s: System voltage connected to converter
% - I: Current to DC Bus (negative current is a consumer, positive a producer.)
% - eta_down: Buck Efficiency
% - eta_up: Boost Efficiency


% parameters
eta_down = par.eta_down;
eta_up   = par.eta_up;


producer = false;
U_out = 0;
U_in  = 0;

% producer/consumer mode:
if( I < 0 ) 
    % ... consumer from bus
    U_out = U_s;
    U_in  = U_bus;
else
    % ... producer to bus
    producer = true;
    U_out    = U_bus;
    U_in     = U_s;
end

% buck/boost mode:
if( U_out < U_in )
    % Buck conversion
    eta = eta_down;
else 
    % Boost conversion
    eta = eta_up;
end


P_s = U_s*I;

if( producer )
    P_bus = P_s*eta;
    I_bus = P_bus/U_bus;
else
    P_bus = P_s/eta;
    I_bus = P_bus/U_bus;
end

% heat generation
% P_bus < P_s < 0 for consumer current.
Q_gen = P_s-P_bus; 

end





















