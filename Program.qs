namespace QuantumHello {
    import Microsoft.Quantum.Convert.*;
    import Microsoft.Quantum.Math.*;

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation Main() : Unit {
        let max = 100000000;
        Message($"{Random(max)}");
    }

    operation Random(max : Int) : Int {
        mutable list = [];
        let range = BitSizeI(max);
        for idx in 1..range {
            list += [Quant()];
        }

        let res = ResultArrayAsInt(list);
        return res > max ? Random(max) | res;
    }

    operation Quant() : Result {
        use q = Qubit();
        H(q);
        let res = M(q);
        Reset(q);
        return res;
    }
}

