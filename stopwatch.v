/*
		Student Name: Yang Li
		Studen Number: 1715977	
*/
module stopwatch(clk_100hz,
													system_reset,
													reset, //key2
													pause, //switch sw2
													switch_mode,
													sec_H,
													sec_L,
													ms_H,
													ms_L);
input 										clk_100hz;
													
input 										reset,	
													pause,
													system_reset;
input [1:0 ]						switch_mode;
output [3:0]					sec_H,	
													sec_L,
													ms_H,
													ms_L;			
													
reg	[3:0]							sec_H,
													sec_L,
													ms_H,
													ms_L;													

always @(posedge clk_100hz )
begin
			if(system_reset ==0)
			begin
						ms_L <= 4'b0000;
						ms_H <= 4'b0000;
						sec_H <= 4'b0000;
						sec_L <= 4'b0000;
			end
			
			else 
			begin	
						if(switch_mode == 2'b01)
						begin
									if(~reset)
									begin
												ms_L <= 4'b0000;
												ms_H <= 4'b0000;
												sec_H <= 4'b0000;
												sec_L <= 4'b0000;
									end
													
									else if(pause)
									begin
												ms_L <= ms_L;
												ms_H <= ms_H;
												sec_H <= sec_H;
												sec_L <= sec_L;						
									end
									
									else
									begin
												ms_L <= ms_L + 4'b0001; 
												if(ms_L == 4'b1001)
												begin
															ms_L <= 4'b0000;
															ms_H <= ms_H+ 4'b0001;
												end
												
												if(ms_L == 4'b1001 && ms_H == 4'b1001)
												begin
															ms_H <= 4'b000;
															sec_L <= sec_L + 4'b0001;
												end
												
												if(sec_L == 4'b1001 &&(ms_H == 4'b0101 && ms_L == 4'b1001))
												begin
															sec_L <= 4'b0000;
															sec_H <= sec_H + 4'b0001;
												end
												
												if(	(sec_H == 4'b0101 &&  sec_L == 4'b1001)	&&	(ms_H == 4'b0101 && ms_L == 4'b1001)	) 
												begin
															ms_L <= 4'b0000;
															ms_H <= 4'b0000;
															sec_H <= 4'b0000;
															sec_L <= 4'b0000;
												end
									end			
						end
			end
end

endmodule

