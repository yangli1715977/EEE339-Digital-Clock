/*
		Student Name: Yang Li
		Studen Number: 1715977	
*/
module Display_clock(clk_1khz,
															switch_mode,
															//modify
															pos_set,
															system_reset,
															//over
															clock_min_H,
															clock_min_L,
															clock_sec_H,
															clock_sec_L,
															stopwatch_sec_H,
															stopwatch_sec_L,		
															stopwatch_ms_H,
															stopwatch_ms_L,															
															display_seg_1,
															display_seg_2,
															display_seg_3,
															display_seg_4
														);
input 												clk_1khz;
input 												system_reset;
input[1:0] 								switch_mode;
//modify
input[1:0]									pos_set;
//over
input[3:0] 								clock_min_H,
															clock_min_L,
															clock_sec_H,
															clock_sec_L,
															stopwatch_sec_H,
															stopwatch_sec_L,
															stopwatch_ms_H,
															stopwatch_ms_L;
															
output [6:0]							display_seg_1,
															display_seg_2,
															display_seg_3,
															display_seg_4;
															
reg [6:0]										display_seg_1,
															display_seg_2,
															display_seg_3,
															display_seg_4;															
reg [3:0]										display_1,
															display_2,
															display_3,
															display_4;
															
reg [1:0] 									loop_clock,
															loop_stopwatch,
															loop_time_set;
integer 										CNT;

always@(posedge clk_1khz)
begin
if(system_reset ==0)
begin
				display_seg_1 =  7'b0000000;
				display_seg_2 =  7'b0000000;
				display_seg_3 =  7'b0000000;
				display_seg_4 =  7'b0000000;
end

else  
begin
			if(switch_mode == 2'b01)
			begin			
						display_4 <= stopwatch_sec_H;
						display_3 <=stopwatch_sec_L;
						display_2 <=stopwatch_ms_H;
						display_1 <= stopwatch_ms_L;
						
						case(loop_stopwatch)
									2'b00: 
									begin
												case(display_1)
															4'b0000 : display_seg_1 = 7'b1000000;
															4'b0001 : display_seg_1 = 7'b1111001;
															4'b0010 : display_seg_1 = 7'b0100100;
															4'b0011 : display_seg_1 = 7'b0110000;
															4'b0100 : display_seg_1 = 7'b0011001;
															4'b0101 : display_seg_1 = 7'b0010010;
															4'b0110 : display_seg_1 = 7'b0000010;
															4'b0111 : display_seg_1 = 7'b1111000;
															4'b1000 : display_seg_1 = 7'b0000000;
															4'b1001 : display_seg_1 = 7'b0010000;
															default   : display_seg_1 = 7'b1111111; 
													endcase
									end
									2'b01:
									begin
												case(display_2)
															4'b0000 : display_seg_2 = 7'b1000000;
															4'b0001 : display_seg_2 = 7'b1111001;
															4'b0010 : display_seg_2 = 7'b0100100;
															4'b0011 : display_seg_2 = 7'b0110000;
															4'b0100 : display_seg_2 = 7'b0011001;
															4'b0101 : display_seg_2 = 7'b0010010;
															4'b0110 : display_seg_2 = 7'b0000010;
															4'b0111 : display_seg_2 = 7'b1111000;
															4'b1000 : display_seg_2 = 7'b0000000;
															4'b1001 : display_seg_2 = 7'b0010000;
															default : display_seg_2 = 7'b1111111; 
													endcase
									end
									2'b10:
									begin
												case(display_3)
															4'b0000 : display_seg_3 = 7'b1000000;
															4'b0001 : display_seg_3 = 7'b1111001;
															4'b0010 : display_seg_3 = 7'b0100100;
															4'b0011 : display_seg_3 = 7'b0110000;
															4'b0100 : display_seg_3 = 7'b0011001;
															4'b0101 : display_seg_3 = 7'b0010010;
															4'b0110 : display_seg_3 = 7'b0000010;
															4'b0111 : display_seg_3 = 7'b1111000;
															4'b1000 : display_seg_3 = 7'b0000000;
															4'b1001 : display_seg_3 = 7'b0010000;
															default : display_seg_3 = 7'b1111111; 
													endcase
									end
									2'b11:
									begin		
												case(display_4)
															4'b0000 : display_seg_4 = 7'b1000000;
															4'b0001 : display_seg_4 = 7'b1111001;
															4'b0010 : display_seg_4 = 7'b0100100;
															4'b0011 : display_seg_4 = 7'b0110000;
															4'b0100 : display_seg_4 = 7'b0011001;
															4'b0101 : display_seg_4 = 7'b0010010;
															4'b0110 : display_seg_4 = 7'b0000010;
															4'b0111 : display_seg_4 = 7'b1111000;
															4'b1000 : display_seg_4 = 7'b0000000;
															4'b1001 : display_seg_4 = 7'b0010000;
															default : display_seg_4 = 7'b1111111; 
													endcase
									end
				
						endcase
		
						loop_stopwatch <= loop_stopwatch + 2'b01;
						if(loop_stopwatch == 2'b11)
						begin
										loop_stopwatch <= 2'b00;
						end
			end
			//clock
			else if( switch_mode == 2'b00)
			begin
						display_4 <= 	clock_min_H;
						display_3 <=	clock_min_L;
						display_2 <= 	clock_sec_H;
						display_1 <=	clock_sec_L;		
						
						loop_clock <= loop_clock + 2'b01;
						if(loop_clock == 2'b11)
						begin
									loop_clock <= 2'b00;
						end
						
						case(loop_clock)
									2'b00: 
									begin
												case(display_1)
															4'b0000 : display_seg_1 = 7'b1000000;
															4'b0001 : display_seg_1 = 7'b1111001;
															4'b0010 : display_seg_1 = 7'b0100100;
															4'b0011 : display_seg_1 = 7'b0110000;
															4'b0100 : display_seg_1 = 7'b0011001;
															4'b0101 : display_seg_1 = 7'b0010010;
															4'b0110 : display_seg_1 = 7'b0000010;
															4'b0111 : display_seg_1 = 7'b1111000;
															4'b1000 : display_seg_1 = 7'b0000000;
															4'b1001 : display_seg_1 = 7'b0010000;
															default   : display_seg_1 = 7'b1111111; 
													endcase
									end
									2'b01:
									begin
												case(display_2)
															4'b0000 : display_seg_2 = 7'b1000000;
															4'b0001 : display_seg_2 = 7'b1111001;
															4'b0010 : display_seg_2 = 7'b0100100;
															4'b0011 : display_seg_2 = 7'b0110000;
															4'b0100 : display_seg_2 = 7'b0011001;
															4'b0101 : display_seg_2 = 7'b0010010;
															4'b0110 : display_seg_2 = 7'b0000010;
															4'b0111 : display_seg_2 = 7'b1111000;
															4'b1000 : display_seg_2 = 7'b0000000;
															4'b1001 : display_seg_2 = 7'b0010000;
															default : display_seg_2 = 7'b1111111; 
													endcase
									end
									2'b10:
									begin
												case(display_3)
														4'b0000 : display_seg_3 = 7'b1000000;
														4'b0001 : display_seg_3 = 7'b1111001;
														4'b0010 : display_seg_3 = 7'b0100100;
														4'b0011 : display_seg_3 = 7'b0110000;
														4'b0100 : display_seg_3 = 7'b0011001;
														4'b0101 : display_seg_3 = 7'b0010010;
														4'b0110 : display_seg_3 = 7'b0000010;
														4'b0111 : display_seg_3 = 7'b1111000;
														4'b1000 : display_seg_3 = 7'b0000000;
														4'b1001 : display_seg_3 = 7'b0010000;
														default : display_seg_3 = 7'b1111111; 
												endcase
									end
									2'b11:
									begin		
												case(display_4)
															4'b0000 : display_seg_4 = 7'b1000000;
															4'b0001 : display_seg_4 = 7'b1111001;
															4'b0010 : display_seg_4 = 7'b0100100;
															4'b0011 : display_seg_4 = 7'b0110000;
															4'b0100 : display_seg_4 = 7'b0011001;
															4'b0101 : display_seg_4 = 7'b0010010;
															4'b0110 : display_seg_4 = 7'b0000010;
															4'b0111 : display_seg_4 = 7'b1111000;
															4'b1000 : display_seg_4 = 7'b0000000;
															4'b1001 : display_seg_4 = 7'b0010000;
															default : display_seg_4 = 7'b1111111; 
													endcase
									end
	
					endcase
		
	
			end
			
		//time_set
			else if(switch_mode == 2'b10 )
			begin
						//display_4 <= 	clock_min_H;
						//display_3 <=	clock_min_L;
						//display_2 <= 	clock_sec_H;
						//display_1 <=	clock_sec_L;
						loop_time_set <= loop_time_set + 2'b01;
						if(loop_time_set == 2'b11)
						begin
									loop_time_set <= 2'b00;
						end
						
						if(pos_set == 2'b00)
						begin										
										display_4 <= 	clock_min_H;
										display_3 <=	clock_min_L;
										display_2 <= 	clock_sec_H;	
										
										if(CNT <500)
										begin
													display_1 <= clock_sec_L;
													CNT <= CNT +1;
										end
									
										else if(CNT >=500 && CNT<1000)
										begin
													CNT <= CNT +1;
													display_1 <= 4'b1111;														
										end
										else if( CNT == 1000)
													CNT <= 0;
														
						end
									
						else if(pos_set == 2'b01)
						begin
										display_4 <= 	clock_min_H;
										display_3 <=	clock_min_L;										
										display_1 <=	clock_sec_L;
										
									if(CNT <500)
										begin
													display_2 <= clock_sec_H;
													CNT <= CNT +1;
										end
									
										else if(CNT >=500 && CNT<1000)
										begin
													CNT <= CNT +1;
													display_2 <= 4'b1111;														
										end
										else if( CNT == 1000)
													CNT <= 0;
						end
						
						else if(pos_set == 2'b10)
						begin
										display_4 <= 	clock_min_H;									
										display_2 <= 	clock_sec_H;
										display_1 <=	clock_sec_L;
										
										if(CNT <500)
										begin
													display_3 <= clock_min_L;
													CNT <= CNT +1;
										end
										
										else if(CNT >=500 && CNT<1000)
										begin
													CNT <= CNT +1;
													display_3 <= 4'b1111;														
										end
										else if( CNT == 1000)
													CNT <= 0;
						end
						
						else if(pos_set == 2'b11)
						begin																	
										display_3 <=	clock_min_L;
										display_2 <= 	clock_sec_H;
										display_1 <=	clock_sec_L;
										
										if(CNT <500)
										begin
													display_4 <= clock_min_H;
													CNT <= CNT +1;
										end
										
										else if(CNT >=500 && CNT<1000)
										begin
													CNT <= CNT +1;
													display_4 <= 4'b1111;														
										end
										else if( CNT == 1000)
													CNT <= 0;
						end
											
					case(loop_time_set)
						2'b00: 
						begin
									case(display_1)
												4'b0000 : display_seg_1 = 7'b1000000;
												4'b0001 : display_seg_1 = 7'b1111001;
												4'b0010 : display_seg_1 = 7'b0100100;
												4'b0011 : display_seg_1 = 7'b0110000;
												4'b0100 : display_seg_1 = 7'b0011001;
												4'b0101 : display_seg_1 = 7'b0010010;
												4'b0110 : display_seg_1 = 7'b0000010;
												4'b0111 : display_seg_1 = 7'b1111000;
												4'b1000 : display_seg_1 = 7'b0000000;
												4'b1001 : display_seg_1 = 7'b0010000;
												default   : display_seg_1 = 7'b1111111; 
										endcase
						end
						2'b01:
						begin
									case(display_2)
												4'b0000 : display_seg_2 = 7'b1000000;
												4'b0001 : display_seg_2 = 7'b1111001;
												4'b0010 : display_seg_2 = 7'b0100100;
												4'b0011 : display_seg_2 = 7'b0110000;
												4'b0100 : display_seg_2 = 7'b0011001;
												4'b0101 : display_seg_2 = 7'b0010010;
												4'b0110 : display_seg_2 = 7'b0000010;
												4'b0111 : display_seg_2 = 7'b1111000;
												4'b1000 : display_seg_2 = 7'b0000000;
												4'b1001 : display_seg_2 = 7'b0010000;
												default : display_seg_2 = 7'b1111111; 
										endcase
						end
						2'b10:
						begin
									case(display_3)
												4'b0000 : display_seg_3 = 7'b1000000;
												4'b0001 : display_seg_3 = 7'b1111001;
												4'b0010 : display_seg_3 = 7'b0100100;
												4'b0011 : display_seg_3 = 7'b0110000;
												4'b0100 : display_seg_3 = 7'b0011001;
												4'b0101 : display_seg_3 = 7'b0010010;
												4'b0110 : display_seg_3 = 7'b0000010;
												4'b0111 : display_seg_3 = 7'b1111000;
												4'b1000 : display_seg_3 = 7'b0000000;
												4'b1001 : display_seg_3 = 7'b0010000;
												default : display_seg_3 = 7'b1111111; 
										endcase
						end
						2'b11:
						begin		
									case(display_4)
												4'b0000 : display_seg_4 = 7'b1000000;
												4'b0001 : display_seg_4 = 7'b1111001;
												4'b0010 : display_seg_4 = 7'b0100100;
												4'b0011 : display_seg_4 = 7'b0110000;
												4'b0100 : display_seg_4 = 7'b0011001;
												4'b0101 : display_seg_4 = 7'b0010010;
												4'b0110 : display_seg_4 = 7'b0000010;
												4'b0111 : display_seg_4 = 7'b1111000;
												4'b1000 : display_seg_4 = 7'b0000000;
												4'b1001 : display_seg_4 = 7'b0010000;
												default : display_seg_4 = 7'b1111111; 
										endcase
						end
				
					endcase
													
			end
end

end


endmodule
			//ms
	/*		
			case(loop)
			2'b00: 
			begin
						case(display_1)
									4'b0000 : display_seg_1 = 7'b1000000;
									4'b0001 : display_seg_1 = 7'b1111001;
									4'b0010 : display_seg_1 = 7'b0100100;
									4'b0011 : display_seg_1 = 7'b0110000;
									4'b0100 : display_seg_1 = 7'b0011001;
									4'b0101 : display_seg_1 = 7'b0010010;
									4'b0110 : display_seg_1 = 7'b0000010;
									4'b0111 : display_seg_1 = 7'b1111000;
									4'b1000 : display_seg_1 = 7'b0000000;
									4'b1001 : display_seg_1 = 7'b0010000;
									default   : display_seg_1 = 7'b1111111; 
							endcase
			end
			2'b01:
			begin
						case(display_2)
									4'b0000 : display_seg_2 = 7'b1000000;
									4'b0001 : display_seg_2 = 7'b1111001;
									4'b0010 : display_seg_2 = 7'b0100100;
									4'b0011 : display_seg_2 = 7'b0110000;
									4'b0100 : display_seg_2 = 7'b0011001;
									4'b0101 : display_seg_2 = 7'b0010010;
									4'b0110 : display_seg_2 = 7'b0000010;
									4'b0111 : display_seg_2 = 7'b1111000;
									4'b1000 : display_seg_2 = 7'b0000000;
									4'b1001 : display_seg_2 = 7'b0010000;
									default : display_seg_2 = 7'b1111111; 
							endcase
			end
			2'b10:
			begin
						case(display_3)
									4'b0000 : display_seg_3 = 7'b1000000;
									4'b0001 : display_seg_3 = 7'b1111001;
									4'b0010 : display_seg_3 = 7'b0100100;
									4'b0011 : display_seg_3 = 7'b0110000;
									4'b0100 : display_seg_3 = 7'b0011001;
									4'b0101 : display_seg_3 = 7'b0010010;
									4'b0110 : display_seg_3 = 7'b0000010;
									4'b0111 : display_seg_3 = 7'b1111000;
									4'b1000 : display_seg_3 = 7'b0000000;
									4'b1001 : display_seg_3 = 7'b0010000;
									default : display_seg_3 = 7'b1111111; 
							endcase
			end
			2'b11:
			begin		
						case(display_4)
									4'b0000 : display_seg_4 = 7'b1000000;
									4'b0001 : display_seg_4 = 7'b1111001;
									4'b0010 : display_seg_4 = 7'b0100100;
									4'b0011 : display_seg_4 = 7'b0110000;
									4'b0100 : display_seg_4 = 7'b0011001;
									4'b0101 : display_seg_4 = 7'b0010010;
									4'b0110 : display_seg_4 = 7'b0000010;
									4'b0111 : display_seg_4 = 7'b1111000;
									4'b1000 : display_seg_4 = 7'b0000000;
									4'b1001 : display_seg_4 = 7'b0010000;
									default : display_seg_4 = 7'b1111111; 
							endcase
			end
	
		endcase
		
		loop <= loop + 2'b01;
		if(loop == 2'b11)
		begin
					loop <= 2'b00;
		end
		//
		//if(loop == pos_set)
		//begin
		
		
		//end
*/
