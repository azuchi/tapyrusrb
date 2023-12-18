require "spec_helper"

describe Tapyrus::Store::DB::LevelDB do
  let (:chain) do
    create_test_chain
  end
  subject { chain.db }
  after { chain.db.close }

  describe "#get_hash_from_height" do
    let(:payloads) do
      %w[
        010000008add6b1d1547e5793d9ae2e6ae5fea385f909a54d8d72f5a8ff7c27548118b03478f5da5750223cc8f1119b5d49111564533f319d15b6cf523299c0aa48ccc46b17df463553646417f6d18c686a8321edbdd5805e13682951289acd2a41a80e49dbdbc5e0040fa1dcab3ffdb5667ae476e7afa9e1cc15961e8501457c18565b964a1ca411996b90e97fab5e715ae716bcff7fee5a28834af87c97445cb58612a550242aa3e37
        0100000081038c7b08c511efccf21d451d1075ecf3e41c464b4c5c2a6729581e342cfd536aa2519c8204db78da162e7ef415a3471a94c398bc98f83c1bea6cc23e26635ce2555325ace27d47ad06b2d8ebc3746445d31d35b0e52a3238294fea5e4cfd6ce4c0bc5e0040ade37f48b67bd8d336e0b724dc29d3f8186a63e94c6741849637f0fa181ad6dd8a66214ec0613bb3fe865f1eef213aab865307d027c5e8779af73c1f7d18da68
        010000006c281f247858b3a15a883883f3b6c088a0e933d97bc47688e504f5be9f2cee77e476dba79e75fc0263c917d2ab40a34c1ab7510aba4020d79fa9ad3cfb3ae834c716cff6adf31e2846e905d391f89b3ca81273db405ad1ca0945b79f2c795e023cc3bc5e0040352d6ca481aeab106383da215e05109fa9167ec8284a8e0864905a990f3a1fb67d4a3d4c2111d51c3d9597a5ebd5f466b7959e80250edaf43b62978389d8e867
        01000000052a5cfed3a398991b1318f0db80730778dbdb9830d753f712dfa798a6505e7c745b8e2695a7ba371fbacca632a18ae3ff7cb3c4e2e6bb8ab68518e4597b73229274257fe065aa5dcc0bf7930f31d75abf65b6a5fe7af0c9de908707c089f69863c4bc5e00408769b1d7fb89adc4a4636d80a263e7f8b7c2f64baf3d0f298e0ce259f48bdf79f8874c846d5a2510254551973f1e388be349796dc128f929b77eb840a99113a3
        01000000634064f75ac2441a9df34c5841954c23fd0ef77e5c59d1045e19ddf56dc9ad7572ed737be371a1bd95e082da5ce62d36fe5a85bdcc4290299bbd2be05d0e8ea0bc8f34244bc929e359f84877d96f96c210581c5a2670f3b616317e150c1444b3bcc6bc5e0040ce776fd1dd68b3500db987780e58ea87b4d544643590decfed6d9e9345b2cc00df1c27ec29fe5b3ba0e7af2d424abb8cd8c4e0fafa46e9af0188dd4dd125cc67
        01000000d6be2f61c9f66819a29abfed07958d6adbbecf33706f4618d0d178f1c84ee8042e03a276675d5275057765b4e89eb29b8952f62df4da697a5c87459c39844abd218cf587f7b76a3d4ff6e908a865d563390e00bbf0e35a692a787d3f70858ccfe3c7bc5e0040baca6e9a2f1f1f46a4860f71cbff909a0f36633652f101995da9a7703b049fdb18bcf5fc4d5ba5d19ea07c8c0541df64f5cb092e8511bb68c56c19605ca1a458
        0100000061d3dbf0f9361389452767e7b8168fc3590f17129358fe46b99c21cd3520bfd297bac30b70dd6a32c8a69afa7b58558d5b2547fdc94abc47af6d1eef00551f43b9b1c790da8e2eb8d1419929d778f427161dbdf356c7176ec3fcad0b9dbb84ac3ccabc5e004040f7b99a2c6badfbf258fb42b7b670a8bc34d426c0e16b015809e8101283b2f3431e15a9816ef6cf00a9335f1a929e60c2f430dbeb076ead2534d257aa57ca44
        010000008a92b353347b54282e5c173c34b834697a0b97faaac30d9c323398b84d5ad55b60719f11a7f951164cde845609355e16315ccedbc1d9ce113f43efe85041389e45df93e854f6788e865c77f8f5b24797215f462535dea7bcee63fdf1b5fffff263cbbc5e0040b289b418ca13eb508ec1f949d59b1762bf8421790c10d1e5932ae163479e3d63d5019f132d860c00926332c792f1869417a123f434a3587e505638609103abb9
        010000009d77b48bd5295865887b2ade3228fcd3f03fa7d84735ed617aa6fd17a39aa320c2aef173ce966279f63352f4918a2c8c711f7ec1ac8b1901c81fcdf608b25d65e1be3ea2979e6ef4d3a7d3c49856c92d7b9b3bec4f50af06fb7e470b5fd1f655bbcdbc5e0040c2a8657f7317b776d5c5c9d6dea1bba187000c0da6a638584464bbff2c974cbd2f2d4d3f6a9ffdb295770ebd0021262aab2e970f98f10d121dec640faf5bd90c
        0100000005bb979efeffeb39747f308574abd41a0f6ab588e4f82bb241f52addd424b7321c4c94e0f08cc32662abc0c1ed6b088736dec6c9d5edb4186de8da5165ff17cdb6560ae862f5dd55d4e3c295e169f96980faa28ede1fd3f102886a35cb05c699e3cebc5e00409b8dc64376aa1561a81f7c61c35c72aa0ec501af98deb6a72d06ef8b21173e747afbc19511dc763f25e1e1243033d78d41dd6b51513f893497fcb461dfdfdcd8
        01000000093d772a2ee72a37813a1a855988e8a5aa9e192fca61f1ddb41e81e9d0daa1dc15dc75f357a3807a7f76cc331894434d9d74cc2a93850f4390c504289b084cfa33bb2d66b8ef30f38ab5517b54c1315c9f2a6a109694d47025dfce6d6fcb10cc3bd1bc5e0040713d4676634113ac5141c38a0a40a3eb9e8cbc8987ddfcf6ac897ae8f0d5be0ce11aeb5d3b4325b0739e6b0f4f33159974c8a20e5f5aefe9e3ab4ede19951072
        010000000eb8cd798b890bccbe076ed76765ab7e536d0cf15a517506efac5b779b6599cedeaa2ad56b53e648f8ad56825af2825151da23fecbf7483b58facdb4bbf50e02745e2d27b71d6be6bb2ebc34d24a4f5335396de345f19586f0cbe912ff1cd02863d2bc5e00407c7f44cf1a7a77b62dfbe4c4713378af80f203bd6215c4e143c141fc62b8e6c64209e761e6b70af8665482631e57265c337cc447f3ebe0cef186875d4c41fcdb
        01000000def79b0fd3783ead23b32e7b96597e50e2971fb60989be454b993cc38e58f4a25602c3872fe033420b9340a22a681b5ae4ad383b23029ca6190bdee26787d7be13151347d4439471cac1ec2e547947a61ce9f1cbfa938b5c546049263641ca9abbd4bc5e00400dd8e1c44bdeb493838f5e47e7334d2082dd1d145f67756b026fa082d42659fe7975bf5dedfbcf464e2e035aa08694826b56530b98ad726a3f511b9428f77c5f
        010000000e538a62f7d45df71370fdd8b17427864a1140452e7dce3c4ac8f4a60a23b74b4f797aa81d64f4210f6820048830542e7c34457313890bbe1f85e71a6c680271e21c89ca691b65f6979cab5c1feb6b2551c0c98c06b3fe47a135902323510cf0e2d5bc5e004035df835c30583f1ad0539d45d0d0ee7f5d6d2080e17f45c501fb1ac137d0dab7972c2f264fb1fbed8937dfd259079f3817be247722687d8ddc6167a14cac7c5d
        0100000038bb2941482b06c6bad367269fc93ebe04e250b924a0d20bd5b6d90c1c69daab556a724cd4ba5f5796ae1dc42cc8e97bc7bae9e49f309a71793e24421481b27628e0a4b167f8d96d93a2f2a44fc0b32cafefc22816b3988e935976956a422fcf3bd8bc5e0040aa095b6cd483643b03408fa651055594d08ab37c62f1eb23a5ae4796515c155094e01a9084c1c0f36d86512984bfab4ca6cddf28435050d82c42b5419aca73d7
        01000000c7e24a33c9d740ce1245353fbaa91e1a814a02662180a5e0ec9eb287c5821bce8c96d7a92ebd502c0fc3bd0ad315ea390044684d0626b3fc9cf7baef9e1e16762e58fdb0554735b4233203d731c7c9fc390a3ac4ce9fb2d1087ebaba33eba09f62d9bc5e0040532e0e972ca64cc7b0c27d7f9be2a28a83c0cc5e1ce07d50c9dcfaadfa6479966c3d5f97634d97f883f593d592d60af3c121d6935280051eb5da28e04d902301
      ]
    end

    before do
      payloads.each_with_index do |payload, i|
        header = Tapyrus::BlockHeader.parse_from_payload(payload.htb)
        subject.save_entry(Tapyrus::Store::ChainEntry.new(header, i + 1))
      end
    end

    it do
      # see: https://github.com/haw-itn/bitcoinrb/issues/8
      expect(subject.get_hash_from_height(1)).to eq "81038c7b08c511efccf21d451d1075ecf3e41c464b4c5c2a6729581e342cfd53"
      expect(subject.get_hash_from_height(16)).to eq "ebfd42418e2460a42d98a20d5344c305d511bce93c2a4745399c83c86ce21050"
    end
  end

  describe "#agg_pubkeys" do
    it "should return aggregated public key list." do
      expect(subject.agg_pubkeys.size).to eq(1)
      expect(subject.agg_pubkeys.first[0]).to eq(0)
      expect(subject.agg_pubkeys.first[1]).to eq("0366262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b")

      subject.add_agg_pubkey(300, "02157bc6dc9dc7a25d537f36d4714c0cfc11c882f017a989e16956cc1aa8cce20a")
      expect(subject.agg_pubkeys.size).to eq(2)
      expect(subject.agg_pubkeys[1][0]).to eq(300)
      expect(subject.agg_pubkeys[1][1]).to eq("02157bc6dc9dc7a25d537f36d4714c0cfc11c882f017a989e16956cc1aa8cce20a")
    end
  end

  describe "#latest_agg_pubkey" do
    it "should return latest one." do
      expect(subject.latest_agg_pubkey).to eq("0366262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b")
      subject.add_agg_pubkey(300, "02157bc6dc9dc7a25d537f36d4714c0cfc11c882f017a989e16956cc1aa8cce20a")
      subject.add_agg_pubkey(301, "0266262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b")
      expect(subject.latest_agg_pubkey).to eq("0266262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b")
    end
  end

  describe "#agg_pubkey_with_height" do
    it "should return target aggregated public key." do
      expect(subject.agg_pubkey_with_height(0)).to eq(
        "0366262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b"
      )
      subject.add_agg_pubkey(150, "02157bc6dc9dc7a25d537f36d4714c0cfc11c882f017a989e16956cc1aa8cce20a")
      subject.add_agg_pubkey(301, "0266262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b")
      expect(subject.agg_pubkey_with_height(149)).to eq(
        "0366262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b"
      )
      expect(subject.agg_pubkey_with_height(150)).to eq(
        "02157bc6dc9dc7a25d537f36d4714c0cfc11c882f017a989e16956cc1aa8cce20a"
      )
      expect(subject.agg_pubkey_with_height(300)).to eq(
        "02157bc6dc9dc7a25d537f36d4714c0cfc11c882f017a989e16956cc1aa8cce20a"
      )
      expect(subject.agg_pubkey_with_height(301)).to eq(
        "0266262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b"
      )
      expect(subject.agg_pubkey_with_height(1050)).to eq(
        "0266262690cbdf648132ce0c088962c6361112582364ede120f3780ab73438fc4b"
      )
    end
  end
end
