function run_simulation()
    
dynare simulate
delete simulate_dynamic.m simulate.m simulate_results.mat simulate_static.m simulate.log simulate_set_auxiliary_variables.m
rmdir('simulate', 's')
    