/*
		Student Name: Yang Li
		Studen Number: 1715977	
*/
module Digital_Clock(clk_50hz,
														clk_1hz,
														system_reset,
														pos_time_setting,//key1
														time_add,						//key2
														time_reduce,				//key3
														switch_mode,
														min_H,
														min_L,
														sec_H,
														sec_L,
														//modify
														pos_set);
														//over
														
input 											clk_50hz, 
														clk_1hz;
														
input										   system_reset;

input 											pos_time_setting,
														time_add,	
														time_reduce;
														
input [1:0] 							switch_mode;

output [3:0] 						min_H,	
														min_L,	
														sec_H,	
														sec_L;
														
reg [3:0]									min_H,	
														min_L,	
														sec_H,	
														sec_L;
														
reg[3:0] 									min_H_set, 
														min_L_set, 
														sec_H_set, 
														sec_L_set;
														
reg [3:0] 								temp_min_H,	
														temp_min_L, 
														temp_sec_H,
														temp_sec_L;
//modidy
output[1:0]							pos_set;
//over
reg[1:0]  								pos_set;

reg												loop;
reg[3:0]									conflict;

//clock count
always@(posedge clk_1hz)
begin
		if(system_reset == 0)
		begin
					min_H <= 4'b0000;
					min_L<= 4'b0000;
					sec_H  <= 4'b0000;
					sec_L	<= 4'b0000;
					temp_sec_H	<=		4'b0000;  
					temp_sec_L	<=		4'b0000;
					temp_min_H	<=		4'b0000;
					temp_min_L	<= 	4'b0000;
					
		end
		else begin
		if(switch_mode == 2'b10)
		begin
						sec_H <= sec_H_set;
						sec_L <= sec_L_set;
						min_H <= min_H_set;
						min_L <= min_L_set;	
		end
						
		//else if(switch_mode == 2'b00)
		else if(switch_mode == 2'b00)
		begin					
						sec_L <= sec_L + 4'b0001;
		
						if(sec_L == 4'b1001)
						begin	
									sec_L <= 4'b0000;
									sec_H <= sec_H + 4'b0001;
						end
		
						if(sec_H == 4'b0101 && sec_L == 4'b1001)
						begin
									sec_H  <= 4'b0000;
									min_L <= min_L + 4'b0001;
						end
		
						if(min_L == 4'b1001 &&(sec_H == 4'b0101 && sec_L == 4'b1001))
						begin
									min_L <= 4'b0000;
									min_H <= min_H + 4'b0001;
						end
						if((min_H >= 4'b0101 && min_L >= 4'b1001) &&(sec_H >= 4'b0101 && sec_L >= 4'b1001))
						begin
									min_H <= 4'b0000;
									min_L<= 4'b0000;
									sec_H  <= 4'b0000;
									sec_L	<= 4'b0000;
						end
						
						temp_sec_H	<=		sec_H;  
						temp_sec_L	<=		sec_L;
						temp_min_H	<=		min_H;
						temp_min_L	<=		min_L;	
						
			
			end
end
end
//____________________________________________

//____________________________________________
//time_setting
always@(posedge clk_50hz )//posedge clk_50hz )//or posedge pos_time_setting or )
begin
				if(system_reset == 0)
				begin		
								sec_H_set <=	4'b0000;
								sec_L_set	<= 4'b0000;
								min_H_set <= 4'b0000;
								min_L_set <= 4'b0000 ;
								pos_set		<= 2'b00;
								
				
				end
				
			else			
			begin
					
					if(switch_mode == 2'b10)
							begin
							if(loop == 0)
							begin			
										sec_H_set <=	temp_sec_H;
										sec_L_set	<= temp_sec_L;//+ 4'b0001; // to solve bug (when switch the mode to time_set, the value of sec_L will reduce 1 )
										min_H_set <= temp_min_H;
										min_L_set <= temp_min_L ;	
										loop <= loop +1;
					
							end
				// determine the position which is changed

							
							if(~pos_time_setting)
							
							begin						
										if(pos_set == 2'b11)
										begin
													pos_set <= 2'b00;
										end
										else
													pos_set <= pos_set+2'b01;
							end
							// second_LOW - time setting
							if(pos_set==2'b00)
							begin
										if(~time_add)
															
										begin
													if(sec_L_set == 4'b1001)
													begin
																sec_L_set <= 4'b0000;
													end
													else
																sec_L_set <= sec_L_set + 4'b0001;
													end
										if(~time_reduce)
														
													begin
													if(sec_L_set == 4'b0000)
													begin
																sec_L_set <= 4'b1001;
													end
													else
																sec_L_set <= sec_L_set - 4'b0001;
													
													end
							end
							//second_HIGH -time setting
							if(pos_set==2'b01)
							begin
										if(~time_add)
														
										begin
													if(sec_H_set == 4'b0101)
													begin
																sec_H_set <= 4'b0000;
													end
													else
																sec_H_set <= sec_H_set + 4'b0001;
							end
													
													if(~time_reduce)										
													begin
													if(sec_H_set == 4'b0000)
													begin
																sec_H_set <= 4'b0101;
													end
													else
																sec_H_set <= sec_H_set - 4'b0001;
																
							end
							end
										//min_LOW -time setting
										if(pos_set==2'b10)
										begin
														
													if(~time_add)
																
													begin
																if(min_L_set == 4'b1001)
																begin
																			min_L_set <= 4'b0000;
																end
																else
																			min_L_set <= min_L_set + 4'b0001;
													end
											
													if(~time_reduce)										
													begin
																	if(min_L_set == 4'b0000)
																	begin
																				min_L_set <= 4'b1001;
																	end
																	else
																				min_L_set <= min_L_set - 4'b0001;
																
													end
										end
										//min_HIGH - time setting
										if(pos_set == 2'b11)
										begin
													
													if(~time_add)
													
													begin
																if(min_H_set == 4'b0101)
																begin
																			min_H_set <= 4'b0000;
																end
																else
																			min_H_set <= min_H_set + 4'b0001;
													end
												
														if(~time_reduce)										
													begin
																	if(min_H_set == 4'b0000)
																	begin
																				min_H_set <= 4'b0101;
																	end
																	else
																				min_H_set <= min_H_set - 4'b0001;
																
													end
													
										end
										//finish
		
				end
	else if(switch_mode == 2'b00)
	begin
				loop <= 0;
	end

	end	
end


endmodule
