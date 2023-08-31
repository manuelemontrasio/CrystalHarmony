/* ----------------- SuperCollider code for CPAC module 1 Project ---------------------------- */
/* The following instructions have to be followed BEFORE compiling the Processing code:
   1) Connect the MIDI device to the PC and be sure that it is turned on.
   2) Reboot the server.
   3) Compile the code region with cmd+enter (ctrl+enter) to initialise MIDI connections and create MIDIdefs, SynthDefs and OSCdefs.
   4) Run Processing code and start playing.
*/

s.reboot;
Server.killAll; // Compile only to kill the server.

//////////////////////////////////////////////////////////////////////
//////
(   // Click cmd+enter (ctrl+enter) here to compile the region.
//////
//////////////////////////////////////////////////////////////////////
v = s.volume;

MIDIClient.init;
MIDIIn.connectAll; // To connect Midi

// Show net values to use in Processing
NetAddr.localAddr;

// Notes
~notesRhodes = Array.newClear(128);
~notesFm = Array.newClear(128);
~notesKal = Array.newClear(128);
~notesSynth = Array.newClear(128);


///////////////////////////////////////////////////////////////////////////////////////////////
//
// MIDIDEFS
//
///////////////////////////////////////////////////////////////////////////////////////////////

// Note ON
MIDIdef.noteOn(\noteOnTest, {
	// "key down".postln
	arg vel, note, midiChan, src; // midiChan from 0 to 15 (in total 16)
	// [vel, note].postln;
	~notesRhodes[note] = Synth.new(\rhodes, [
		\freq, note.midicps,
		\amp, vel.linexp(1, 127, 0.01, 1),
		\gate, 1,
		\att, ~att,
		\rel, ~rel+0.15
	]);
	~notesFm[note] = Synth.new(\fm, [
		\freq, note.midicps,
		\amp, vel.linexp(1, 127, 0.01, 1),
		\gate, 1,
		\att, ~att,
		\rel, ~rel+0.15,
		\room, ~rel/10
	]);
	~notesKal[note] = Synth.new(\kalimba, [
		\freq, note.midicps,
		\amp, vel.linexp(1, 127, 0.01, 1),
		\gate, 1,
		\att, ~att/5,
		\rel, ~rel+0.5,
		\room, ~rel/10
	]);
	~notesSynth[note] = Synth.new(\sawsynth, [
		\freq, note.midicps,
		\amp, vel.linexp(1, 127, 0.01, 1),
		\gate, 1,
		\att, ~att,
		\rel, ~rel+0.15,
		\room, ~rel/2.5
	]);
	// postln(~att);
});


// Note OFF
MIDIdef.noteOff(\noteOffTest, {
	arg vel, note;
	// [vel, note].postln;
	~notesRhodes[note].set(\gate, 0);
	~notesRhodes[note] = nil;
	~notesFm[note].set(\gate, 0);
	~notesFm[note] = nil;
	~notesKal[note].set(\gate, 0);
	~notesKal[note] = nil;
	~notesSynth[note].set(\gate, 0);
	~notesSynth[note] = nil;
});


///////////////////////////////////////////////////////////////////////////////////////////////
//
// SYNTHDEFS
//
///////////////////////////////////////////////////////////////////////////////////////////////

/***************************
**
** Rhodes Synth
**
****************************/
SynthDef(\rhodes, {
    |
    // a different way of defining arguments
    out = 0, freq = 440, gate = 1, pan = 0, amp = 0.5, vol = 0, lev = 0.2
    // all of these range from 0 to 1, lfoSpeed ranges between 0 and 12
    modIndex = 0.2, mix = 0.1, lfoSpeed = 4.8, lfoDepth = 0.1, att = 0, rel = 1
    |
    var env1, env2, env3, env4;
    var osc1, osc2, osc3, osc4, snd;

	freq = freq * 2;

    env1 = EnvGen.ar(Env.adsr(0.001, 1.25, 0, 0.04, curve: \lin)) ;
	env2 = EnvGen.ar(Env.adsr(0.001, 1.00, 0, 0.04, curve: \lin)) ;
    env3 = EnvGen.ar(Env.adsr(0.001, 1.50, 0, 0.04, curve: \lin)) ;
    env4 = EnvGen.ar(Env.adsr(0.001, 1.50, 0, 0.04, curve: \lin)) ;

    osc4 = SinOsc.ar(freq * 0.5) * 2pi * 1.071 * modIndex* env4 ;
    osc3 = SinOsc.ar(freq, osc4) * env3;
    osc2 = SinOsc.ar(freq * 15) * 2pi * 0.108819 * env2;
    osc1 = SinOsc.ar(freq, osc2) * env1;

	snd = (osc3 * (1 - mix)) + (osc1 * mix);

    snd = snd * (SinOsc.ar(lfoSpeed) * lfoDepth + 1);

    snd = snd * EnvGen.ar(Env.adsr(att, 1, 1, rel), gate, doneAction: 2);
    snd = Pan2.ar(snd, pan, amp*0.5);

    Out.ar(out, snd*vol*lev);
}).add;

/***************************
**
** FM Synth
**
****************************/
SynthDef.new(\fm, {
	| freq = 200, mRatio = 1, cRatio = 1, modAmp = 20, att = 0.01, rel = 1, c0 = 1, c1 = (-1), amp = 0.2, pan = 0, out= 0 , oct = 0, vol = 0, lpf = 20000, hpf = 0, dw = 0.33, room = 0.7, damp = 0.5, gate = 0, lev = 0.5|
	var car, mod, env, sig;

	env = EnvGen.kr(Env.adsr(att,0.3,0.9,rel),gate, doneAction: 2);
	mod = SinOsc.ar(freq*(2**oct)*mRatio,mul:modAmp);
	car = SinOsc.ar(freq*(2**oct)*cRatio + mod)*env*amp*vol*lev;
	car = Pan2.ar(car, pan);
	sig = HPF.ar(LPF.ar(car, lpf), hpf);
	Out.ar(out, FreeVerb.ar(sig, dw, room, damp));
}).add;


/***************************
**
** Kalimba Synth
**
****************************/
SynthDef(\kalimba, {
    |out = 0, freq = 440, amp = 0.5, mix = 0.05, rel = 2.5, oct = 0, vol = 0, lpf = 20000, hpf = 0, dw = 0.33, room = 1, damp = 0.5, gate = 0, lev = 0.5, att = 0.005 |
    var snd, sig;

	snd = SinOsc.ar(freq * (2**oct)) * EnvGen.ar(Env.perc(att, rel, 1, -8), gate, doneAction: 2);
    snd = ((snd * (1 - mix)) + (DynKlank.ar(`[
        [240*ExpRand(0.9, 1.1), 2020*ExpRand(0.9, 1.1), 3151*ExpRand(0.9, 1.1)],
        [-7, 0, 3].dbamp,
        [0.8, 0.05, 0.07]
	], PinkNoise.ar * EnvGen.ar(Env.perc(0.001, 0.01))) * mix));
	sig = HPF.ar(LPF.ar(snd, lpf), hpf);
	Out.ar(out, Pan2.ar(FreeVerb.ar(sig, dw, room, damp), 0)*amp*vol*lev);
}).add;

/***************************
**
** SuperSaw Synth
**
****************************/
SynthDef(\sawsynth, {
	| freq = 440, amp = 0, att = 0.1, rel = 2, lofreq = 1000, hifreq = 3000, oct = 0, vol = 0, lpf = 20000, hpf = 0, dw = 0.33, room = 0.1, damp = 0.5, lev = 0.3, gate = 0 |
    var env, snd, sig;
    env = EnvGen.kr(Env.adsr(att,0.3,1,rel),gate,doneAction: 2);
	snd = Saw.ar(freq: freq *(2**oct)* [0.99, 1, 1.001, 1.008], mul: env);
	snd = LPF.ar(snd, LFNoise2.kr(1).range(lofreq, hifreq));
    snd = Splay.ar(snd)*amp*vol*lev;
	sig = HPF.ar(LPF.ar(snd, lpf), hpf);
	Out.ar(0, FreeVerb.ar(sig, dw, room, damp));
}).add;


///////////////////////////////////////////////////////////////////////////////////////////////
//
// OSCDEFS (LINK WITH PROCESSING)
//
///////////////////////////////////////////////////////////////////////////////////////////////
// Listen to OSC messages:

// ==============================
// /rhodes message (see Processing)
// ==============================
OSCdef('processingRhodes', {
    arg msg;
	~notesRhodes.do({arg note, i; note.set(\vol, msg[1]);});
}, "/rhodes");


// ==============================
// /fm message
// ==============================
OSCdef('processingFm', {
    arg msg;
	~notesFm.do({arg note, i; note.set(\vol, msg[1]);});
}, "/fm");


// ==============================
// /kalimba message
// ==============================
OSCdef('processingKalimba', {
    arg msg;
	~notesKal.do({arg note, i; note.set(\vol, msg[1]);});
}, "/kalimba");


// ==============================
// /synth message
// ==============================
OSCdef('processingSynth', {
    arg msg;
	~notesSynth.do({arg note, i; note.set(\vol, msg[1]);});
}, "/synth");


// ==============================
// /att message
// ==============================
OSCdef('processingAttack', {
    arg msg;
	~att = msg[1];
}, "/att");


// ==============================
// /rel message
// ==============================

OSCdef('processingRelease', {
    arg msg;
	~rel = msg[1];
}, "/rel");


// ==============================
// /volume message
// ==============================
OSCdef('processingVolume', {
    arg msg;
	v.volume = 20*log10((msg[1]+0.1)/100);
	// postln(v.volume);
}, "/volume");


//////////////////////////////////////////////////////////////////////
//////
"Supercollider ready! Now run Processing code.".postln;
//////
//////////////////////////////////////////////////////////////////////
)

















