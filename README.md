# CBO4filters

### MATLAB code for designing fractional-order low pass Butterworth filter in terms of integer-order rational approximation using a metaheuristic optimization technique called Colliding Bodies Optimisation (CBO)

---

Fractional order filters of order (n+a) have better roll-off than just integer order filters. But implementing fraction order filters would require fractance devices. So a easy way would be doing an integer-order approximation of the fractional filter. It is done by optimizing the error between the magnitude of the fractional-order filter function and the integer-order fractional function.

A report on such paper says:

> The objective function for such an optimization problem can be formulated such that the error between the ideal response and the response produced by the proposed integer order transfer function approximation is minimized. The coefficients of the numerator and the denominator polynomials of the proposed model are the design variables for the optimization routine. This optimization problem is a multidimensional one since all the coefficients of the integer order filter are used as the decision variables. Furthermore, this particular optimization problem is multimodal in nature. Hence a sophisticated and robust global optimization technique must be employed to produce optimal solution.

In this term CBO gives a very good performance and being parameter independent there is no issue of parameter tuning. So in this program CBO uses a iterative technique to minimize the error and give the optimal set of integer-order filter coefficients that would behave same as that of the fractional order.

Previous studies show the performance of CBO is very good and it is also easy to implement. Other types of digital filters can also be replicated the same way.

For further queries feel free to ping me: `letter2srm@gmail.com`
