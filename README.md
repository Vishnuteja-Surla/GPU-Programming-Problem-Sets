# CS6023 - GPU Programming

Solutions to the topic-wise Problem Sets assigned as part of **CS6023: GPU Programming**, offered at the Indian Institute of Technology Madras by **Rupesh Nasre**.

## Repository Structure

The repository is organized into three folders, with each folder containing the code solutions for the corresponding topic-wise Problem Set.

```text
.
├── Computation/
│   └── Problem Set 1 solutions
├── Memory/
│   └── Problem Set 2 solutions
├── Synchronization/
│   └── Problem Set 3 solutions
└── README.md
└── .gitignore
```

| Topic           | Problem Set |
| --------------- | ----------- |
| Computation     | PS1         |
| Memory          | PS2         |
| Synchronization | PS3         |

## Technology Stack

* **Programming Language:** CUDA C/C++
* **Compiler:** NVIDIA CUDA Compiler (`nvcc`)

## Code Organization

* Each folder corresponds to a course topic and contains its relevant Problem Set solutions.
* Each code file includes the corresponding problem statement at the top as a comment for reference.
* The repository contains code solutions only.

## Compilation and Execution

Ensure that the CUDA Toolkit is installed and that `nvcc` is available in your system's PATH.

Navigate to the directory containing the desired solution and compile it using:

```bash
nvcc source_file.cu -o executable_name
```

Run the compiled executable using:

```bash
./executable_name
```

For example:

```bash
cd Computation
nvcc question1.cu -o question1
./question1
```

Replace `source_file.cu`, `executable_name`, and the example file names with the appropriate names of the solution you want to compile and execute.

## Academic Integrity

This repository is intended for educational purposes and personal reference.

The solutions are provided to support learning and understanding of GPU programming concepts. If you are enrolled in CS6023 or a similar course, please adhere to the course's academic integrity policies and complete assigned work independently. Do not submit these solutions as your own work.

## Course Information

* **Course:** CS6023 — GPU Programming
* **Institution:** Indian Institute of Technology Madras
* **Instructor:** Rupesh Nasre
