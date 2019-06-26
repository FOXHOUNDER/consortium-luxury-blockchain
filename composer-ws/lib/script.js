/**
 * Track the trade of a commodity from one trader to another
 * @param {org.unimib.clb.Trade} trade - the trade to be processed
 * @transaction
 */
async function tradeCommodity(trade) {
    trade.commodity.owner = trade.newOwner;
    let assetRegistry = await getAssetRegistry('org.unimib.clb.Commodity');
    await assetRegistry.update(trade.commodity);
}
