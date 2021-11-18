/*
		Student Name: Yang Li
		Studen Number: 1715977	
*/
module key_filter(	clk,
													system_reset,
													key_in,
													key_out

 );
 
 input 					clk;
 
 input 					system_reset,
									key_in;
									
output 				key_out;

wire 						clk,
									system_reset,
									key_in;
									
reg							key_out;
						


//    localparam TIME_20MS = 1_000_000;
    localparam TIME_20MS = 1000_000; //1000_000

    reg key_cnt;
    reg [20:0] cnt;

   always @(posedge clk or negedge system_reset) begin
        if(system_reset == 0)
            key_cnt <= 0;
        else if(cnt == TIME_20MS - 1)
            key_cnt <= 0;
        else if(key_cnt == 0 && key_out != key_in)
            key_cnt <= 1;
    end

    always @(posedge clk or negedge system_reset) begin
        if(system_reset == 0)
            cnt <= 0;
        else if(key_cnt) begin
            if(key_out == key_in)
                cnt <= 0;
            else
                cnt <= cnt + 1'b1;
        end
        else
            cnt <= 0;
    end
     
     always @(posedge clk or negedge system_reset) begin
            if(system_reset == 0)
                key_out <= 0;
            else if(cnt == TIME_20MS - 1)
                key_out <= key_in;
     end
endmodule





/*module key_filter(clk,
												system_reset,
												key,
												key_out											
);

input		 				clk;
input  					system_reset,
									key;
									
output 				key_out;

reg 							key_out,
									key_value,
									key_flag,
									key_reg;
// 50MHZ的一个时钟周期是20ns，除按键抖动频率0.2s，
// delay_cnt  count 1000_000
reg[19:0]	delay_cnt;
//延时计数器
always@(posedge clk or negedge system_reset)
begin
			if(~system_reset)
			begin
						key_reg <= 1'b1;
						delay_cnt <= 20'b0;
			end
			
			else
			begin
						 key_reg <= key;
						 if(key != key_reg)
									delay_cnt <= 20'd1000000;		
						else
						begin
									if(delay_cnt > 20'd0)
												delay_cnt <= delay_cnt -1'b1;
									else
												delay_cnt <= 20'd0;
						end
			 end		
end
//根据延时计数器的值去判断什么时候输出 消抖按键的值
always@(posedge clk or negedge system_reset)
begin
			if(~system_reset)
			begin
						key_value <= 1'b1;
						key_flag <= 1'b0;
			end
			else
			begin
						if(delay_cnt == 20'd1)
						begin
									key_flag <= 1'b1;
									key_value <= key;
						end
						
						else
						begin
									key_flag <= 1'b0;
									key_value <= key_value;
						end
			end
end
always@(posedge clk)
begin
			if(key_flag && (~key_value))
						key_out <= 1'b0;
			else
						key_out <= 1'b1;
end
endmodule

*/