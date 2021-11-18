/*
		Student Name: Yang Li
		Studen Number: 1715977	

		SW9 DOWN ---- System Reset
		SW9 UP---- System Start
											___________													_______________												_________________
		Digital Clock  	|		SW9 UP		|					StopWatch 	|		SW9 UP					|					Time Set		|			SW9 UP						|				
											|	SW0 DOWN	|													|		SW0 UP					|												|			SW0 DOWN				|
											|	SW1 DOWN	|													|		SW1 DOWN			|												|			SW1 UP						|
											——————													|			Function	:			|												|			Function:					|
																																	|	SW2 UP(Pause)	|												|		KEY1(Position)			|
																																	|	KEY2 (Reset)			|												|		KEY2(Add Time		|
																																	————————												|	KEY3(Reduce Time)	|
																																																									—————————					
*/
																																													
module Clock_top(clk,
												system_reset,
												switch_pause,
												switch_mode,
												key1,
												key2,
												key3,
												display_seg_1,
												display_seg_2,
												display_seg_3,
												display_seg_4,
												
												);
												
input 									clk;
input 									system_reset,
												switch_pause,
												key1,
												key2,
												key3;
input[1:0]						switch_mode;
//display
output[6:0]					display_seg_1,
												display_seg_2,
												display_seg_3,
												display_seg_4;
//clock frequency												
wire										clk_1HZ,
												clk_50HZ,
												clk_100HZ,
												clk_1KHZ;

wire[1:0]						pos_set;


//key output
wire										key1_out,
												key2_out,
												key3_out;
//clock_time												
wire[3:0]						clock_min_H,
												clock_min_L,
												clock_sec_H,
												clock_sec_L;
//stopwatch												
wire[3:0]						stopwatch_sec_H,
												stopwatch_sec_L,
												stopwatch_ms_H,
												stopwatch_ms_L;	

								
												
key_filter key1_o(				.clk										(clk),
																.system_reset			(system_reset),
																.key_in										(key1),
																.key_out							(key1_out)								
);

key_filter key2_o(				.clk										(clk),
																.system_reset			(system_reset),
																.key_in										(key2),
																.key_out							(key2_out)								
);

key_filter key3_o(				.clk										(clk),
																.system_reset			(system_reset),
																.key_in										(key3),
																.key_out							(key3_out)							
);

Div_Freq Div_Freq(
																.clk 										(clk),
																.clk_1HZ							(clk_1HZ),
																.clk_50HZ						(clk_50HZ),
																.clk_100HZ					(clk_100HZ),
																.clk_1KHZ						(clk_1KHZ)
																);
stopwatch stopWatch(
																.clk_100hz					(clk_100HZ),
																.system_reset			(system_reset), //switch9
																.reset									(key2_out), //key2
																.pause								(switch_pause), //switch 2
																.switch_mode			(switch_mode),		
																.sec_H								(stopwatch_sec_H),
																.sec_L								(stopwatch_sec_L),
																.ms_H								(stopwatch_ms_H),
																.ms_L								(stopwatch_ms_L)
																);
																										
													
Display_clock display	(
															.clk_1khz							(clk_1KHZ),
															.switch_mode				(switch_mode),
															.pos_set								(pos_set),
															.system_reset				(system_reset),
															.clock_min_H				(clock_min_H),
															.clock_min_L					(clock_min_L),
															.clock_sec_H					(clock_sec_H),
															.clock_sec_L					(clock_sec_L),
															.stopwatch_sec_H	(stopwatch_sec_H),
															.stopwatch_sec_L		(stopwatch_sec_L),
															.stopwatch_ms_H	(stopwatch_ms_H),
															.stopwatch_ms_L		(stopwatch_ms_L),															
															.display_seg_1				(display_seg_1),
															.display_seg_2				(display_seg_2),
															.display_seg_3				(display_seg_3),
															.display_seg_4				(display_seg_4)											
															);


Digital_Clock clock (
															.clk_50hz							(clk_50HZ),
															.clk_1hz								(clk_1HZ),
															.system_reset				(system_reset),
															.pos_time_setting	(key1_out),//key1
															.time_add							(key2_out),	//key2
															.time_reduce					(key3_out),	//key3
															.switch_mode				(switch_mode),
															.min_H									(clock_min_H),
															.min_L									(clock_min_L),
															.sec_H									(clock_sec_H),
															.sec_L									(clock_sec_L),
															//modify
															.pos_set								(pos_set)
															//over
														);
																																						
															
endmodule