# Fixed-Wing UAV Modeling and Simulation in Simulink

This project involves the modeling and simulation of a fixed-wing unmanned aerial vehicle (UAV) using MATLAB and Simulink. The project focuses on comparing two modeling approaches and visualizing the UAV's flight in FlightGear.

## 🚀 Project Overview

- The UAV was first modeled in MATLAB using scripts and transferred to Simulink via function blocks.
- A second model was created directly within the Simulink environment.
- Both models were analyzed and compared in terms of structure, modularity, and simulation behavior.
- The final Simulink model was integrated with FlightGear for real-time flight visualization.

## 🧰 Tools & Technologies

- MATLAB  
- Simulink  
- FlightGear (for real-time flight visualization)

## 📂 Project Structure

## 📝 Key Features

- Comparison between MATLAB function-based and native Simulink model architectures  
- Dynamic modeling of a fixed-wing UAV  
- Integration with FlightGear for realistic flight simulation  
- Evaluation of flight response and model performance

## ⚙️ How to Run

1. Open `simulinkmodel.slx` in MATLAB Simulink. (Only Simulink model)
2. Open `simulinkmodel_function.slx` in MATLAB Simulink. (Simulin model built with MATLAB function Block from `EOMs_of_AC.m` )
3. Open `constants_simulinkmodel` in MATLAB and run.
4. Connect Simulink to FlightGear if visualization is needed.
5. Run the simulation and observe UAV behavior.

## 👨‍💻 Author

Eyüp Burak Özden  
