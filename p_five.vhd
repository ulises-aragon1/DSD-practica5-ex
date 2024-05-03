LIBRARY IEEE
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;

ENTITY p_five IS
	PORT(
		clk: in std_logic;
		salida : out std_logic_vector (2 downto 0);
)
END ENTITY;

ARCHITECTURE p_five_ar OF p_five
	TYPE estado IS (S0, S1, S2);
	SIGNAL edo_actual : estado := S3;
	SIGNAL contador : INTEGER RANGE 500000000 DOWN TO 0 := 0;
	CONSTANT max_s0 : INTEGER := 500000000;
	CONSTANT max_s1_1 : INTEGER := 25000000;
	CONSTANT max_s1_2 : INTEGER := 250000000;
	CONSTANT max_s2 : INTEGER := 350000000;
BEGIN

	p_five_process : PROCESS(clk) IS
	BEGIN
		IF rising_edge(clk) THEN
			IF edo_actual == S0 THEN
				IF (contador >= max_s0) THEN
					 contador <= 0;
					 edo_actual <= S1;
				ELSE
					salida <= "100";
					contador <= contador + 1;
				ENDIF;
			ELSEIF edo_actual = S1 THEN
				IF (contador >= max_s1_2) THEN
					 contador <= 0;
					 edo_actual <= S2;
				ELSE
					IF (contador MOD max_s1_1 == 0) THEN
						salida[0] <= '0';
						salida[1] <= not salida[1];
						salida[2] <= '0';
					END IF;
					contador <= contador + 1;
				END IF;
			ELSEIF edo_actual = S2 THEN
				IF (contador >= max_s2) THEN
					 contador <= 0;
					 edo_actual <= S0;
				ELSE
					salida <= "001";
					contador <= contador + 1;
				END IF;
			END IF;
		END IF
	END PROCESS;

END p_five_ar;