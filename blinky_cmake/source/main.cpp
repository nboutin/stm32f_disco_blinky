#include "stm32f4xx_hal.h"

void Init_OnBoard_LEDs(void);
void Delay_ms(volatile int time_ms);

int main(void)
{
  HAL_Init();
  Init_OnBoard_LEDs();
  while (1)
  {
    HAL_GPIO_WritePin(GPIOD, GPIO_PIN_12 | GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15, GPIO_PIN_SET);
    Delay_ms(1000);
    HAL_GPIO_WritePin(GPIOD, GPIO_PIN_12 | GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15, GPIO_PIN_RESET);
    Delay_ms(1000);
  }
}

void Init_OnBoard_LEDs(void)
{
  __HAL_RCC_GPIOD_CLK_ENABLE();
  GPIO_InitTypeDef BoardLEDs;
  BoardLEDs.Mode = GPIO_MODE_OUTPUT_PP;
  BoardLEDs.Pin  = GPIO_PIN_12 | GPIO_PIN_13 | GPIO_PIN_14 | GPIO_PIN_15;
  BoardLEDs.Pull = GPIO_NOPULL;
  HAL_GPIO_Init(GPIOD, &BoardLEDs);
}

void Delay_ms(volatile int time_ms)
{
  int j;
  for (j = 0; j < time_ms * 4000; j++)
  {
  } /* excute NOP for 1ms */
}
