---
layout: default
title: LaTeX Examples
permalink: /latex-examples/
---

# LaTeX Rendering Examples

This page demonstrates various LaTeX mathematical expressions to test the MathJax rendering.

## Inline Mathematics

Here are some inline math examples: The quadratic formula is $x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$, and Euler's identity is $e^{i\pi} + 1 = 0$.

The derivative of $f(x) = x^n$ is $f'(x) = nx^{n-1}$, and the integral $\int_0^1 x^2 dx = \frac{1}{3}$.

## Display Mathematics

### Basic Equations

The Schrödinger equation:

$$i\hbar\frac{\partial}{\partial t}\Psi(x,t) = \hat{H}\Psi(x,t)$$

Maxwell's equations in vacuum:

$$\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$$

$$\nabla \cdot \mathbf{B} = 0$$

$$\nabla \times \mathbf{E} = -\frac{\partial \mathbf{B}}{\partial t}$$

$$\nabla \times \mathbf{B} = \mu_0\mathbf{J} + \mu_0\epsilon_0\frac{\partial \mathbf{E}}{\partial t}$$

### Matrix Operations

A matrix multiplication example:

$$\begin{bmatrix}
a & b \\
c & d
\end{bmatrix}
\begin{bmatrix}
x \\
y
\end{bmatrix}
=
\begin{bmatrix}
ax + by \\
cx + dy
\end{bmatrix}$$

Determinant of a 3×3 matrix:

$$\det(A) = \begin{vmatrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33}
\end{vmatrix}$$

### Calculus

The fundamental theorem of calculus:

$$\int_a^b f(x)\,dx = F(b) - F(a)$$

Taylor series expansion:

$$f(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!}(x-a)^n$$

Fourier transform:

$$\hat{f}(\xi) = \int_{-\infty}^{\infty} f(x)e^{-2\pi ix\xi}\,dx$$

### Complex Analysis

Cauchy's integral formula:

$$f(z_0) = \frac{1}{2\pi i}\oint_C \frac{f(z)}{z-z_0}\,dz$$

Laurent series:

$$f(z) = \sum_{n=-\infty}^{\infty} a_n(z-z_0)^n$$

### Probability and Statistics

Normal distribution:

$$f(x) = \frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{1}{2}\left(\frac{x-\mu}{\sigma}\right)^2}$$

Bayes' theorem:

$$P(A|B) = \frac{P(B|A)P(A)}{P(B)}$$

Expected value:

$$E[X] = \sum_{i=1}^n x_i p_i = \int_{-\infty}^{\infty} xf(x)\,dx$$

### Linear Algebra

Eigenvalue equation:

$$A\mathbf{v} = \lambda\mathbf{v}$$

Singular value decomposition:

$$A = U\Sigma V^T$$

Gram-Schmidt orthogonalization:

$$\mathbf{u}_i = \mathbf{v}_i - \sum_{j=1}^{i-1}\text{proj}_{\mathbf{u}_j}(\mathbf{v}_i)$$

### Number Theory

Euler's theorem:

$$a^{\phi(n)} \equiv 1 \pmod{n}$$

The prime number theorem:

$$\pi(x) \sim \frac{x}{\ln x}$$

### Quantum Mechanics

Heisenberg uncertainty principle:

$$\Delta x \Delta p \geq \frac{\hbar}{2}$$

Time-independent Schrödinger equation:

$$-\frac{\hbar^2}{2m}\nabla^2\psi + V\psi = E\psi$$

Dirac notation:

$$\langle\psi|\hat{A}|\phi\rangle = \int\psi^*\hat{A}\phi\,dx$$

### Special Functions

Gamma function:

$$\Gamma(n) = (n-1)! = \int_0^{\infty} t^{n-1}e^{-t}\,dt$$

Beta function:

$$B(x,y) = \int_0^1 t^{x-1}(1-t)^{y-1}\,dt = \frac{\Gamma(x)\Gamma(y)}{\Gamma(x+y)}$$

### Aligned Equations

Using alignment for multi-step derivations:

$$\begin{align}
(x+y)^2 &= (x+y)(x+y) \\
&= x(x+y) + y(x+y) \\
&= x^2 + xy + yx + y^2 \\
&= x^2 + 2xy + y^2
\end{align}$$

### Cases

Piecewise functions:

$$f(x) = \begin{cases}
x^2 & \text{if } x < 0 \\
x & \text{if } 0 \leq x \leq 1 \\
2-x & \text{if } x > 1
\end{cases}$$

### Limits and Sums

$$\lim_{x \to \infty} \left(1 + \frac{1}{x}\right)^x = e$$

$$\sum_{n=1}^{\infty} \frac{1}{n^2} = \frac{\pi^2}{6}$$

$$\prod_{n=1}^{\infty} \left(1 - \frac{1}{n^2}\right) = \frac{1}{2}$$

## Mixed Content

Here's a paragraph mixing text and mathematics. Consider the function $f(x) = e^{-x^2}$, which is the Gaussian function. Its integral over the entire real line is:

$$\int_{-\infty}^{\infty} e^{-x^2}\,dx = \sqrt{\pi}$$

This result can be proven using the clever trick of squaring the integral and converting to polar coordinates. The function $f(x) = e^{-x^2}$ has many important properties: it's even (i.e., $f(-x) = f(x)$), infinitely differentiable, and its Fourier transform is also a Gaussian.

## Test for Display Mode

Here's a test to ensure display mode works with double dollar signs:

$$E = mc^2$$

And another one:

$$\oint_C \mathbf{F} \cdot d\mathbf{r} = \iint_S (\nabla \times \mathbf{F}) \cdot d\mathbf{S}$$

This page should render all mathematical expressions correctly with MathJax 3.