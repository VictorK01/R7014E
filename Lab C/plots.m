figure(1)
hold on;
plot(out.tout, out.Case2FeedbackSim.signals(1).values)
plot(out.tout, out.Case2FeedbackSim.signals(2).values)
plot(out.tout, out.Case2FeedbackSim.signals(3).values,'--')