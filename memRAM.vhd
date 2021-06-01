library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memRAM is

	port (clk: in std_logic;
			dir: in std_logic_vector(3 downto 0); -- direccion especifica la localidad de la memoria
			dato: in std_logic_vector(1 downto 0);
			lee: in std_logic;
			esc: in std_logic;
			disp: out std_logic_vector(7 downto 0));

end memRAM;

architecture behavioral of memRAM is

	subtype byte is std_logic_vector(7 downto 0); -- 8 bits forman un byte
	type tm is array (0 to 15) of byte; -- tamaño de la memoria
	signal mem: tm;

begin

	process(clk)
	
		variable ind: unsigned(3 downto 0); -- indicador sin signo
	
	begin
	
		if rising_edge(clk) then
			ind := unsigned(dir);
			if lee = '1' then
				disp <= mem(to_integer(ind)); -- de binario a decimal
			elsif esc = '1' then
				mem(to_integer(ind)) <= esc & lee & dato & dir; -- 6 concatena
			end if;
		end if;
	
	end process;

end behavioral;