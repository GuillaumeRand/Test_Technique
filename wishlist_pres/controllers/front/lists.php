<?php

class wishlist_presListsModuleFrontController extends ModuleFrontController
{

    public $auth = true;

    public function initContent()
    {
        parent::initContent();
        $wishlists = $this->module->getAllWishList();
        if ($wishlists) {
            foreach ($wishlists as &$wishlist) {
                $wishlist['products'] = wl_wishList::printProductsById($wishlist['id_wishlist']);
            }
        }
        $this->context->smarty->assign(
            array(
                'url' => $this->context->link->getModuleLink($this->module->name, 'action', ['action' => 'getAllWishlist']),
                'createUrl' => $this->context->link->getModuleLink($this->module->name, 'action', ['action' => 'createNewWishlist']),
                'deleteListUrl' => $this->context->link->getModuleLink($this->module->name, 'action', ['action' => 'deleteWishlist']),
                'deleteProductUrl' => $this->context->link->getModuleLink($this->module->name, 'action', ['action' => 'deleteProductFromWishlist']),
                'renameUrl' => $this->context->link->getModuleLink($this->module->name, 'action', ['action' => 'renameWishlist']),
                'shareUrl' => $this->context->link->getModuleLink($this->module->name, 'action', ['action' => 'getUrlByIdWishlist']),
                'addUrl' => $this->context->link->getModuleLink($this->module->name, 'action', ['action' => 'addProductToWishlist']),
                'accountLink' => '#',
                'wishlistsTitlePage' => Configuration::get('WL_MY_WISHLISTS', $this->context->language->id),
                'newWishlistCTA' => Configuration::get('WL_CREATE_BUTTON_LABEL', $this->context->language->id),
                'wishlists' => $wishlists,
            )
        );
        $this->setTemplate('module:' . $this->module->name . '/views/templates/front/pages/lists.tpl');
    }

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        $breadcrumb['links'][] = $this->addMyAccountToBreadcrumb();
        $breadcrumb['links'][] = [
            'title' => Configuration::get('WL_MY_WISHLISTS', $this->context->language->id),
            'url' => $this->context->link->getModuleLink($this->module->name, 'lists'),
        ];

        return $breadcrumb;
    }
}
