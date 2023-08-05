part of '../rack.page.dart';

class _CardRackList extends StatelessWidget {
  final Rack data;
  const _CardRackList(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: getWidth(),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: Color(0xFFD9D9D9))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Text(data.name),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  "${data.totalProduct} Product",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFABABAB),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "${data.totalQty} Qty",
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFABABAB),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
