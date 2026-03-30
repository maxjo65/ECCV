% reference values
par.T0_clt = 298.15;
par.p0_clt = 101325;

% reference values
par.T0_clt = 273 + 60;
par.p0_clt = 2e5;

% water/glycol mixture
% from coolprop MEG-50% at reference values:
par.rho_clt = 1.0406e+03;
par.cp_clt  = 3.5025e+03;
par.cv_clt  = 3.5025e+03;
par.mu_clt  = 0.0014;
par.k_clt   = 0.4137;
par.H0_clt  = 1.3598e+05;

% for properties, call: (if coolprop is available)
% py.CoolProp.CoolProp.PropsSI('DMASS',        'P', par.p0_clt ,'T', par.T0_clt, 'INCOMP::MEG-50%')
% py.CoolProp.CoolProp.PropsSI('CPMASS',       'P', par.p0_clt ,'T', par.T0_clt, 'INCOMP::MEG-50%')
% py.CoolProp.CoolProp.PropsSI('CVMASS',       'P', par.p0_clt ,'T', par.T0_clt, 'INCOMP::MEG-50%')
% py.CoolProp.CoolProp.PropsSI('VISCOSITY',    'P', par.p0_clt ,'T', par.T0_clt, 'INCOMP::MEG-50%')
% py.CoolProp.CoolProp.PropsSI('CONDUCTIVITY', 'P', par.p0_clt ,'T', par.T0_clt, 'INCOMP::MEG-50%')
% py.CoolProp.CoolProp.PropsSI('H',            'P', par.p0_clt ,'T', par.T0_clt, 'INCOMP::MEG-50%')

