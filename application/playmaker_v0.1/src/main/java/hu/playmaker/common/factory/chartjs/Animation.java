package hu.playmaker.common.factory.chartjs;


import hu.playmaker.common.factory.chartjs.common.enums.Easing;
import hu.playmaker.common.factory.chartjs.common.enums.Mode;

public class Animation {
    private Integer duration, delay;
    private Easing easing;
    private Boolean debug, loop;
    private Mode mode;

    Integer getDuration() {
        return duration;
    }

    Integer getDelay() {
        return delay;
    }

    Easing getEasing() {
        return easing;
    }

    Boolean getDebug() {
        return debug;
    }

    Boolean getLoop() {
        return loop;
    }

    Mode getMode() {
        return mode;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public void setDelay(Integer delay) {
        this.delay = delay;
    }

    public void setEasing(Easing easing) {
        this.easing = easing;
    }

    public void setDebug(Boolean debug) {
        this.debug = debug;
    }

    public void setLoop(Boolean loop) {
        this.loop = loop;
    }

    public void setMode(Mode mode) {
        this.mode = mode;
    }
}
