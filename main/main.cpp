// Copyright 2022 Maquinista.
#include "mcl/hardware/mb.hpp"

mcl::MB mb;

int main() {
  mb.BlockingInitialize();

  for (int i = 0;; i++) {
    const auto rx_message = mb.BlockingReceiveRX();
    mb.Read(rx_message);

    const auto tx_message = mb.Write();
    mb.Send(tx_message);
  }
}