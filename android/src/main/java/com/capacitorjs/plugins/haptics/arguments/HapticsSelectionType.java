package com.capacitorjs.plugins.haptics.arguments;

public class HapticsSelectionType implements HapticsVibrationType {

    private static final long[] timings = { 0, 100 };
    private static final int[] amplitudes = { 0, 100 };

    @Override
    public long[] getTimings() {
        return timings;
    }

    @Override
    public int[] getAmplitudes() {
        return amplitudes;
    }
}
