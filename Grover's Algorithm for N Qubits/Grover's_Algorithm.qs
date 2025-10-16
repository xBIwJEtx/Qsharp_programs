namespace QuantumHello {
    import Std.Arrays.ForEach;
    import Std.Arrays.Most;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arrays;

    @EntryPoint()
    operation Main() : Unit {
        let N = 4;
        use Qubits = Qubit[N];
        ApplyToEach(H, Qubits);

        let target = [One, One, One, One];
        for i in 0..Floor((3.14/2.0)*Sqrt(2.0 ^ IntAsDouble(N)))-1 {
            Oracle(Qubits, target);
            Diffusion(Qubits);
        }

        let result = ForEach(M, Qubits);
        let resultInt = ResultArrayAsInt(result);
        Message($"|{resultInt}⟩");
        
        ResetAll(Qubits);
    }

    operation Oracle(Qubits : Qubit[], target : Result[]) : Unit is Adj + Ctl {
        within {
            for i in 0..Length(Qubits)-1 {
                if target[i] == Zero {
                    X(Qubits[i])
                }
            }
        }
        apply {
            Controlled Z(Most(Qubits), Tail(Qubits));
        }
    }

    operation Diffusion(Qubits : Qubit[]) : Unit{
        within {
            for i in 0..Length(Qubits)-1 {
                H(Qubits[i]);
            }

            for i in 0..Length(Qubits)-1 {
                X(Qubits[i]);
            }
        }
        apply {
            Controlled Z(Most(Qubits), Tail(Qubits));
        }
    }

}


