`timescale 10ns / 1ps

module Controller_test();

    // Declare the inputs as reg type
    reg clk, reset, door_close, start, filled, detergent_added, cycle_timeout, drained, spin_timeout;

    // Declare the outputs as wire type
    wire door_lock, motor_on, fill_value_on, drain_value_on, done, soap_wash, water_wash;

    // Instantiate the automatic washing machine module
    automatic_washing_machine machine1 (
        .clk(clk), 
        .reset(reset), 
        .door_close(door_close), 
        .start(start), 
        .filled(filled), 
        .detergent_added(detergent_added), 
        .cycle_timeout(cycle_timeout), 
        .drained(drained), 
        .spin_timeout(spin_timeout), 
        .door_lock(door_lock), 
        .motor_on(motor_on), 
        .fill_value_on(fill_value_on), 
        .drain_value_on(drain_value_on), 
        .done(done), 
        .soap_wash(soap_wash), 
        .water_wash(water_wash)
    );

    // Generate clock signal
    always
    begin
        #5 clk = ~clk;  // Toggle the clock every 5 time units
    end

    // Initial block to apply the test vectors
    initial
    begin
        // Initialize the inputs
        clk = 0;
        reset = 1;
        start = 0;
        door_close = 0;
        filled = 0;
        drained = 0;
        detergent_added = 0;
        cycle_timeout = 0;
        spin_timeout = 0;
        
        // Apply reset
        #10 reset = 0;
        
        // Start the washing machine with door closed
        #10 start = 1; door_close = 1;
        
        // Simulate filling water
        #20 filled = 1;
        
        // Simulate adding detergent
        #20 detergent_added = 1;
        
        // Simulate washing cycle timeout
        #20 cycle_timeout = 1;
        
        // Simulate draining water
        #20 drained = 1;
        
        // Simulate spin cycle timeout
        #20 spin_timeout = 1;
        
        // Wait for some time and finish simulation
        #20 $finish;
    end

    // Monitor the outputs
    initial
    begin
        $monitor("Time=%0t | clk=%b | reset=%b | start=%b | door_close=%b | filled=%b | detergent_added=%b | cycle_timeout=%b | drained=%b | spin_timeout=%b | door_lock=%b | motor_on=%b | fill_value_on=%b | drain_value_on=%b | soap_wash=%b | water_wash=%b | done=%b",
                 $time, clk, reset, start, door_close, filled, detergent_added, cycle_timeout, drained, spin_timeout, door_lock, motor_on, fill_value_on, drain_value_on, soap_wash, water_wash, done);
      $dumpvars(0, Controller_test);
      $dumpfile("waveform.vcd");
    end

endmodule
