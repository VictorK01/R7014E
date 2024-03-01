figure(1)
hold on;
plot(out.tout, out.Case1SlidingDisturbance.signals(1).values)
plot(out.tout, out.Case1SlidingDisturbance.signals(2).values)
plot(out.tout, out.Case1SlidingDisturbance.signals(3).values,'--')